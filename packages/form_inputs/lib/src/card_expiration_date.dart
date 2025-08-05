import 'package:formz/formz.dart';

/// Validation errors for the [CardExpirationDate] [FormzInput].
enum CardExpirationDateValidationError {
  /// Generic invalid error.
  invalid,

  /// Empty value is also an error.
  empty,
}

/// {@template card_expiration_date}
/// Form input for a card expiration date.
///
/// Supports both:
/// - **MM/YY** format (e.g., `08/29`)
/// - **MMYY** format (e.g., `0829`)
///
/// If validation fails, [CardExpirationDateValidationError] is returned.
/// {@endtemplate}
class CardExpirationDate
    extends FormzInput<String, CardExpirationDateValidationError> {
  /// {@macro card_expiration_date}
  const CardExpirationDate.pure() : super.pure('');

  /// {@macro card_expiration_date}
  const CardExpirationDate.dirty([super.value = '']) : super.dirty();

  /// Regex to match both formats:
  /// - `MMYY` (0829)
  /// - `MM/YY` (08/29)
  static final _expirationDateRegExp = RegExp(r'^(0[1-9]|1[0-2])\/?\d{2}$');

  @override
  CardExpirationDateValidationError? validator(String value) {
    if (value.isEmpty) {
      return CardExpirationDateValidationError.empty;
    }
    if (!_expirationDateRegExp.hasMatch(value)) {
      return CardExpirationDateValidationError.invalid;
    }

    // Check if expiration date is in the future
    final now = DateTime.now();
    final currentYear = now.year % 100;
    final currentMonth = now.month;

    final parts = value.contains('/')
        ? value.split('/')
        : [value.substring(0, 2), value.substring(2, 4)];

    final month = int.tryParse(parts[0]) ?? 0;
    final year = int.tryParse(parts[1]) ?? 0;

    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return CardExpirationDateValidationError.invalid;
    }

    return null;
  }
}

extension CardExpirationDateValidationErrorX
    on CardExpirationDateValidationError {
  /// Converts enum values to user-friendly error messages.
  String errorText() {
    switch (this) {
      case CardExpirationDateValidationError.empty:
        return 'Please enter an expiration date';
      case CardExpirationDateValidationError.invalid:
        return 'Please enter a valid expiration date';
    }
  }
}
