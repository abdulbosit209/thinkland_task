import 'package:navigation/navigation.dart';
import 'package:thinkland_task/home/home_page.dart';
import 'package:thinkland_task/not_found/not_found_page.dart';

final routes = [
  RouteEntry(path: '/', builder: (key, routeData) => const HomePage()),
  RouteEntry(path: '/404', builder: (key, routeData) => const NotFoundPage()),
];