part of 'edit_card_bloc.dart';

sealed class EditCardEvent extends Equatable {
  const EditCardEvent();

  @override
  List<Object?> get props => [];
}

final class CardNumberChanged extends EditCardEvent {
  const CardNumberChanged({required this.cardNumber});
  
  final String cardNumber;

  @override
  List<Object> get props => [cardNumber];
}

final class ValidThruChanged extends EditCardEvent {
  const ValidThruChanged({required this.validThru});

  final String validThru;

  @override
  List<Object> get props => [validThru];
}

final class CardNameChanged extends EditCardEvent {
  const CardNameChanged({required this.cardName});

  final String cardName;

  @override
  List<Object> get props => [cardName];
}

final class BackgroundImageChanged extends EditCardEvent {
  const BackgroundImageChanged({this.backGroundImage});

  final List<int>? backGroundImage;

  @override
  List<Object?> get props => [backGroundImage];
}

final class BlurAmountChanged extends EditCardEvent {
  const BlurAmountChanged({this.blurAmount});

  final double? blurAmount;

  @override
  List<Object?> get props => [blurAmount];
}

final class GradientChanged extends EditCardEvent {
  const GradientChanged({this.gradient});

  final GradientModel? gradient;

  @override
  List<Object?> get props => [gradient];
}

final class Submit extends EditCardEvent {}
