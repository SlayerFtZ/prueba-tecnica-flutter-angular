import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProductViewMode { grid, list }

class ProductViewModeNotifier extends Notifier<ProductViewMode> {
  @override
  ProductViewMode build() => ProductViewMode.grid;

  void toggle() {
    state = state == ProductViewMode.grid
        ? ProductViewMode.list
        : ProductViewMode.grid;
  }
}

final productViewModeProvider =
    NotifierProvider<ProductViewModeNotifier, ProductViewMode>(
      ProductViewModeNotifier.new,
    );
