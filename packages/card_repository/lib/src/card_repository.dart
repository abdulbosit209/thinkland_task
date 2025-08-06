import 'dart:async';
import 'dart:convert';

import 'package:card_repository/src/models/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardNotFoundException implements Exception {}

abstract class CardRepository {
  const CardRepository();

  Stream<List<CardModel>> getCards();

  Future<void> saveCard(CardModel card);

  Future<void> deleteCard(String id);

  Future<void> close();
}

class LocalCardRepository extends CardRepository {
  LocalCardRepository({required SharedPreferences plugin}) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  List<CardModel> _allCards = [];
  List<CardModel> get allCards => _allCards;
  set allCards(List<CardModel> cards) {
    _allCards = cards;
    _cardsController.add(cards);
  }

  final StreamController<List<CardModel>> _cardsController =
      StreamController.broadcast();

  static const kCardCollectionKey = '__cards_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final cardsJson = _getValue(kCardCollectionKey);
    if (cardsJson != null) {
      final cards =
          List<Map<dynamic, dynamic>>.from(json.decode(cardsJson) as List)
              .map(
                (jsonMap) => CardModel.fromJson(
                  Map<String, dynamic>.from(jsonMap),
                ),
              )
              .toList();
      allCards = cards;
    }
  }

  @override
  Stream<List<CardModel>> getCards() async* {
    yield _allCards;
    yield* _cardsController.stream;
  }

  @override
  Future<void> saveCard(CardModel card) {
    final cards = List<CardModel>.from(allCards);
    final cardIndex = cards.indexWhere((t) => t.id == card.id);
    if (cardIndex >= 0) {
      cards[cardIndex] = card;
    } else {
      cards.add(card);
    }

    allCards = cards;
    return _setValue(kCardCollectionKey, json.encode(cards));
  }

  @override
  Future<void> deleteCard(String id) {
    final cards = List<CardModel>.from(allCards);
    final cardIndex = cards.indexWhere((t) => t.id == id);
    if (cardIndex == -1) {
      throw CardNotFoundException();
    } else {
      cards.removeAt(cardIndex);
      allCards = cards;
      return _setValue(kCardCollectionKey, json.encode(cards));
    }
  }

  @override
  Future<void> close() {
    return _cardsController.close();
  }
}
