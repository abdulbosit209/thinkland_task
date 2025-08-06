import 'package:card_repository/card_repository.dart';
import 'package:navigation/navigation.dart';
import 'package:thinkland_task/edit_card/view/edit_card_page.dart';
import 'package:thinkland_task/fetch_cards/view/fetch_all_cards_page.dart';
import 'package:thinkland_task/not_found/not_found_page.dart';

final routes = [
  RouteEntry(path: '/', builder: (key, routeData) => const FetchAllCardsPage()),
  RouteEntry(
    path: '/edit_card',
    builder: (key, routeData) {
      final initialCard = routeData.extra as CardModel?;
      return EditCardPage(initialCard: initialCard);
    },
  ),
  RouteEntry(path: '/404', builder: (key, routeData) => const NotFoundPage()),
];
