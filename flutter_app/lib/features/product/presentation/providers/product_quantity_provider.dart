import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductQuantityNotifier extends Notifier<int> {
  ProductQuantityNotifier(this.productId);

  final int productId;

  @override
  int build() => 1;

  void increase(int max) {
    if (state < max) state++;
  }

  void decrease() {
    if (state > 1) state--;
  }
}

final productQuantityProvider = NotifierProvider.autoDispose
    .family<ProductQuantityNotifier, int, int>(ProductQuantityNotifier.new);
