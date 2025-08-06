part of 'fetch_cards_bloc.dart';

sealed class FetchCardsEvent extends Equatable {
  const FetchCardsEvent();

  @override
  List<Object> get props => [];
}

final class CardsOverviewSubscriptionRequested extends FetchCardsEvent {
  const CardsOverviewSubscriptionRequested();
}