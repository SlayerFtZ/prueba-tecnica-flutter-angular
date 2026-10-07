import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/info_row.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/section.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final dims = product.dimensions;

    final rows = <(IconData, String, String)>[
      if (product.sku.isNotEmpty)
        (Icons.qr_code_2_outlined, 'SKU', product.sku),
      if (product.weight > 0)
        (Icons.scale_outlined, 'Peso', '${product.weight} kg'),
      if (dims != null)
        (
          Icons.straighten_outlined,
          'Dimensiones',
          '${dims.width} × ${dims.height} × ${dims.depth} cm',
        ),
      if (product.minimumOrderQuantity > 1)
        (
          Icons.inventory_2_outlined,
          'Pedido mínimo',
          '${product.minimumOrderQuantity} unidades',
        ),
      if (product.shippingInformation.isNotEmpty)
        (Icons.local_shipping_outlined, 'Envío', product.shippingInformation),
      if (product.warrantyInformation.isNotEmpty)
        (Icons.verified_user_outlined, 'Garantía', product.warrantyInformation),
      if (product.returnPolicy.isNotEmpty)
        (
          Icons.assignment_return_outlined,
          'Devoluciones',
          product.returnPolicy,
        ),
    ];

    if (rows.isEmpty) return const SizedBox.shrink();

    return Section(
      title: 'Información del producto',
      icon: Icons.info_outline_rounded,
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            InfoRow(icon: rows[i].$1, label: rows[i].$2, value: rows[i].$3),
          ],
        ],
      ),
    );
  }
}
