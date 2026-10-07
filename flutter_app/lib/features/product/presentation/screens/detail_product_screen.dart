import 'package:flutter/material.dart';
import 'package:flutter_app/core/error/failure.dart';

import 'package:flutter_app/features/cart/presentation/widgets/cart_button.dart';
import 'package:flutter_app/features/home/presentation/widgets/section_error.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/product_detail_provider.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/availability_row.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/bottom_bar.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/detail_skeleton.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/header.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/image_gallery.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/info_section.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/price_card.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/quantity_selector.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/reviews_section.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/section.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/tags_wrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _pagePadding = 16.0;
const _sectionSpacing = 16.0;

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(productDetailProvider(productId));
    final product = detail.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        actions: const [CartButton()],
      ),
      body: detail.when(
        loading: () => const DetailSkeleton(),
        error: (error, _) => Center(
          child: SectionError(
            message: error is Failure
                ? error.message
                : 'Ocurrió un error inesperado.',
            onRetry: () => ref.invalidate(productDetailProvider(productId)),
          ),
        ),
        data: (product) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(productDetailProvider(productId));
            await ref.read(productDetailProvider(productId).future);
          },
          child: _DetailContent(product: product),
        ),
      ),
      bottomNavigationBar: product == null ? null : BottomBar(product: product),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final inStock = product.stock > 0;
    final images = product.images.isNotEmpty
        ? product.images
        : [product.thumbnail];

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        ImageGallery(images: images, soldOut: !inStock),
        Padding(
          padding: const EdgeInsets.all(_pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(product: product),
              const SizedBox(height: _sectionSpacing),
              PriceCard(product: product),
              const SizedBox(height: _sectionSpacing),
              AvailabilityRow(product: product),
              if (inStock) ...[
                const SizedBox(height: _sectionSpacing),
                QuantitySelector(product: product),
              ],
              const SizedBox(height: _sectionSpacing),
              if (product.description.isNotEmpty) ...[
                Section(
                  title: 'Descripción',
                  icon: Icons.notes_rounded,
                  child: Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(height: 1.45),
                  ),
                ),
                const SizedBox(height: _sectionSpacing),
              ],
              if (product.tags.isNotEmpty) ...[
                Section(
                  title: 'Etiquetas',
                  icon: Icons.sell_outlined,
                  child: TagsWrap(tags: product.tags),
                ),
                const SizedBox(height: _sectionSpacing),
              ],
              InfoSection(product: product),
              if (product.reviews.isNotEmpty) ...[
                const SizedBox(height: _sectionSpacing),
                ReviewsSection(
                  reviews: product.reviews,
                  average: product.rating,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
