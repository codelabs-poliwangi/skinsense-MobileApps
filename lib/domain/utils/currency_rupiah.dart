import 'package:intl/intl.dart';

class CurrencyRupiah {
  static const String _symbol = 'Rp. ';
  static const String _locate = 'id_ID';
  static const int _decimalDigits = 0;

  static String formatPrice(String price) {
    final number = int.tryParse(price);
    if (number != null) {
      // Format harga sesuai dengan format Indonesia
      final formatter = NumberFormat.currency(
        locale: _locate,
        symbol: _symbol,
        decimalDigits: _decimalDigits,
      );
      return formatter.format(number);
    } else {
      return 'Rp. 0';
    }
  }
}
