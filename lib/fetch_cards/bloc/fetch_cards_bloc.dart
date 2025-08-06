import 'package:bloc/bloc.dart';
import 'package:card_repository/card_repository.dart';
import 'package:equatable/equatable.dart';

part 'fetch_cards_event.dart';
part 'fetch_cards_state.dart';

class FetchCardsBloc extends Bloc<FetchCardsEvent, FetchCardsState> {
  FetchCardsBloc({required CardRepository cardRepository})
    : _cardRepository = cardRepository,
      super(FetchCardsState()) {
    on<CardsOverviewSubscriptionRequested>(_cardsOverviewSubscriptionRequested);
  }

  final CardRepository _cardRepository;

  Future<void> _cardsOverviewSubscriptionRequested(
    CardsOverviewSubscriptionRequested event,
    Emitter<FetchCardsState> emit,
  ) async {
    emit(state.copyWith(status: FetchCardsStatus.loading));

    await emit.forEach<List<CardModel>>(
      _cardRepository.getCards(),
      onData: (cards) =>
          state.copyWith(status: FetchCardsStatus.success, cards: cards),
      onError: (_, _) => state.copyWith(status: FetchCardsStatus.failure),
    );
  }
}
