part of 'edit_card_bloc.dart';

enum EditCardStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == EditCardStatus.initial;
  bool get isLoading => this == EditCardStatus.loading;
  bool get isSuccess => this == EditCardStatus.success;
  bool get isFailure => this == EditCardStatus.failure;

  bool get isLoadingOrSuccess => isLoading || isSuccess;
}

final class EditCardState extends Equatable {
  const EditCardState({
    this.cardExpirationDate = const CardExpirationDate.pure(),
    this.cardNumber = const CardNumber.pure(),
    this.initialCard,
    this.backGroundImage,
    this.blurAmount,
    this.cardName,
    this.gradient,
    this.status = EditCardStatus.initial,
  });

  final CardModel? initialCard;
  final EditCardStatus status;
  final String? cardName;
  final CardNumber cardNumber;
  final CardExpirationDate cardExpirationDate;
  final List<int>? backGroundImage;
  final double? blurAmount;
  final GradientModel? gradient;

  bool get isValid =>
      Formz.validate([cardNumber, cardExpirationDate]) &&
      !status.isLoadingOrSuccess;

  bool get isNewCard => initialCard == null;

  @override
  List<Object?> get props => [
    initialCard,
    status,
    cardName,
    cardNumber,
    cardExpirationDate,
    backGroundImage,
    blurAmount,
    gradient,
  ];

  EditCardState copyWith({
    EditCardStatus? status,
    CardModel? Function()? initialCard,
    CardNumber? cardNumber,
    CardExpirationDate? cardExpirationDate,
    String? Function()? cardName,
    List<int>? Function()? backGroundImage,
    double? Function()? blurAmount,
    GradientModel? Function()? gradient,
  }) {
    return EditCardState(
      cardNumber: cardNumber ?? this.cardNumber,
      status: status ?? this.status,
      initialCard: initialCard != null ? initialCard() : this.initialCard,
      cardName: cardName != null ? cardName() : this.cardName,
      cardExpirationDate: cardExpirationDate ?? this.cardExpirationDate,
      backGroundImage: backGroundImage != null
          ? backGroundImage()
          : this.backGroundImage,
      blurAmount: blurAmount != null ? blurAmount() : this.blurAmount,
      gradient: gradient != null ? gradient() : this.gradient,
    );
  }
}
