import 'package:intl/intl.dart';

class HumanFormats {

  static String humanReadableNumber(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0, // Número de dígitos decimales 
      symbol: '\$',     // El símbolo de la moneda, en este caso MXN
    ).format(number);

    return formatterNumber;
  }
}
