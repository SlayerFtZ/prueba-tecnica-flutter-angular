import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_quantity_provider.g.dart';

@riverpod
class ProductQuantityNotifier extends _$ProductQuantityNotifier {
  @override
  int build(int productId) => 1;

  void increase(int max) {
    if (state < max) state++;
  }

  void decrease() {
    if (state > 1) state--;
  }
}
