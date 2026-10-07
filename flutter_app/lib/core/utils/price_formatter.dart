abstract final class PriceFormatter {
  static final _thousands = RegExp(r'\B(?=(\d{3})+(?!\d))');

  static String format(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final integer = parts[0].replaceAll(_thousands, ',');
    return '\$$integer.${parts[1]}';
  }
}

String formatMoney(double value) => '\$${value.toStringAsFixed(2)}';
