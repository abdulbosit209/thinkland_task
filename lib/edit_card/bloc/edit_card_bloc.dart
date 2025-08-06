import 'package:bloc/bloc.dart';
import 'package:card_repository/card_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

part 'edit_card_event.dart';
part 'edit_card_state.dart';

class EditCardBloc extends Bloc<EditCardEvent, EditCardState> {
  EditCardBloc({required CardRepository cardRepository, CardModel? initialCard})
    : _cardRepository = cardRepository,
      super(
        initialCard != null
            ? EditCardState(
                initialCard: initialCard,
                backGroundImage: initialCard.backGroundImage,
                blurAmount: initialCard.blurAmount,
                cardName: initialCard.cardName,
                gradient: initialCard.gradient,
                cardExpirationDate: CardExpirationDate.dirty(
                  initialCard.validThru,
                ),
                cardNumber: CardNumber.dirty(initialCard.cardNumber),
              )
            : EditCardState(),
      ) {
    on<CardNumberChanged>(_cardNumberChanged);
    on<ValidThruChanged>(_validThruChanged);
    on<CardNameChanged>(_cardNameChanged);
    on<BackgroundImageChanged>(_backgroundImageChanged);
    on<BlurAmountChanged>(_blurAmountChanged);
    on<GradientChanged>(_gradientChanged);
    on<DeleteCard>(_deleteCard);
    on<Submit>(_submit);
  }

  final CardRepository _cardRepository;

  void _cardNumberChanged(
    CardNumberChanged event,
    Emitter<EditCardState> emit,
  ) {
    final cardNumber = CardNumber.dirty(event.cardNumber);
    emit(
      state.copyWith(cardNumber: cardNumber, status: EditCardStatus.initial),
    );
  }

  void _validThruChanged(ValidThruChanged event, Emitter<EditCardState> emit) {
    final cardExpirationDate = CardExpirationDate.dirty(event.validThru);
    emit(
      state.copyWith(
        cardExpirationDate: cardExpirationDate,
        status: EditCardStatus.initial,
      ),
    );
  }

  void _cardNameChanged(CardNameChanged event, Emitter<EditCardState> emit) {
    emit(
      state.copyWith(
        cardName: () => event.cardName,
        status: EditCardStatus.initial,
      ),
    );
  }

  void _backgroundImageChanged(
    BackgroundImageChanged event,
    Emitter<EditCardState> emit,
  ) {
    emit(
      state.copyWith(
        backGroundImage: () => event.backGroundImage,
        status: EditCardStatus.initial,
      ),
    );
  }

  void _blurAmountChanged(
    BlurAmountChanged event,
    Emitter<EditCardState> emit,
  ) {
    emit(
      state.copyWith(
        blurAmount: () => event.blurAmount,
        status: EditCardStatus.initial,
      ),
    );
  }

  void _gradientChanged(GradientChanged event, Emitter<EditCardState> emit) {
    emit(
      state.copyWith(
        backGroundImage: () => null,
        gradient: () => event.gradient,
        status: EditCardStatus.initial,
      ),
    );
  }

  Future<void> _deleteCard(
    DeleteCard event,
    Emitter<EditCardState> emit,
  ) async {
    emit(state.copyWith(status: EditCardStatus.loading));
    try {
      await _cardRepository.deleteCard(state.initialCard!.id);
      emit(state.copyWith(status: EditCardStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditCardStatus.failure));
    }
  }

  Future<void> _submit(Submit event, Emitter<EditCardState> emit) async {
    if (!state.isValid) return;

    final card = (state.initialCard ?? CardModel()).copyWith(
      backGroundImage: state.backGroundImage,
      blurAmount: state.blurAmount,
      cardName: state.cardName,
      cardNumber: state.cardNumber.value,
      gradient: state.gradient,
      validThru: state.cardExpirationDate.value,
    );

    emit(state.copyWith(status: EditCardStatus.loading));
    try {
      await _cardRepository.saveCard(card);
      emit(state.copyWith(status: EditCardStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditCardStatus.failure));
    }
  }
}
