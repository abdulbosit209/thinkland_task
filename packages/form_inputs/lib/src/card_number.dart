import 'package:formz/formz.dart';

/// Validation errors for the [CardNumber] [FormzInput].
enum CardNumberValidationError {
  /// Generic invalid error.
  invalid,

  /// Empty value is also an error.
  empty,
}

/// {@template card_number}
/// Form input for a user card number input.
///
/// If validation fails, [CardNumberValidationError] is returned.
/// Supports both:
/// - 16-digit format without spaces: "1234567890123456"
/// - 16-digit format with spaces every 4 digits: "1234 5678 9012 3456"
/// {@endtemplate}
class CardNumber extends FormzInput<String, CardNumberValidationError> {
  /// {@macro card_number}
  const CardNumber.pure() : super.pure('');

  /// {@macro card_number}
  const CardNumber.dirty([super.value = '']) : super.dirty();

  /// Regex to match both formats:
  /// - "1234567890123456" (16 digits, no spaces)
  /// - "1234 5678 9012 3456" (spaces every 4 digits)
  static final _cardNumberRegExp =
      RegExp(r'^(?:\d{16}|\d{4} \d{4} \d{4} \d{4})$');

  @override
  CardNumberValidationError? validator(String value) {
    if (value.isEmpty) return CardNumberValidationError.empty;

    return _cardNumberRegExp.hasMatch(value)
        ? null
        : CardNumberValidationError.invalid;
  }
}

extension CardNumberValidationErrorX on CardNumberValidationError {
  /// Converts enum values to user-friendly error messages.
  String errorText() {
    switch (this) {
      case CardNumberValidationError.empty:
        return 'Please enter a card number';
      case CardNumberValidationError.invalid:
        return 'Please enter a valid 16-digit card number';
    }
  }
}
