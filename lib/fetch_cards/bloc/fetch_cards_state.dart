part of 'fetch_cards_bloc.dart';

enum FetchCardsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == FetchCardsStatus.initial;
  bool get isLoading => this == FetchCardsStatus.loading;
  bool get isSuccess => this == FetchCardsStatus.success;
  bool get isFailure => this == FetchCardsStatus.failure;
}

final class FetchCardsState extends Equatable {
  const FetchCardsState({
    this.cards = const [],
    this.status = FetchCardsStatus.initial,
  });

  final FetchCardsStatus status;
  final List<CardModel> cards;

  @override
  List<Object> get props => [status, cards];

  FetchCardsState copyWith({FetchCardsStatus? status, List<CardModel>? cards}) {
    return FetchCardsState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
    );
  }
}
