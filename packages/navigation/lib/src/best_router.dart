import 'package:flutter/widgets.dart';
import 'package:navigation/src/route_information_parser.dart';
import 'package:navigation/src/router_delegate.dart';
import 'package:navigation/src/router_service.dart';

class BestRouterConfig extends RouterConfig<Object> {
  BestRouterConfig({required RouterService routerService})
    : super(
        routerDelegate: AppRouterDelegate(routerService: routerService),
        routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(
            uri: Uri.parse(
              routerService.navigationStack.value.last.uri.toString(),
            ),
          ),
        ),
        backButtonDispatcher: RootBackButtonDispatcher(),
        routeInformationParser: AppRouteInformationParser(
          routes: routerService.supportedRoutes,
        ),
      );
}

/*
locator<RouterService>().goTo(Path(name: '/new-route'));
locator<RouterService>().replace(Path(name: '/new-route'));
locator<RouterService>().back();
locator<RouterService>().backUntil(Path(name: '/new-route'));
locator<RouterService>().replaceAll([Path(name: '/new-route'), Path(name: '/new-route-2')]);
locator<RouterService>().remove(Path(name: '/new-route'));

// configure the route in route_config.dart
RouteEntry(path: '/todos/:id', builder: (key, routeData) {
  final id = routeData.pathParameters['id'];
  return TodoView(id: id);
}),

// go to the route
locator<RouterService>().goTo(Path(name: '/todos/123'));

// configure the route in route_config.dart
RouteEntry(path: '/todos', builder: (key, routeData) {
  final id = routeData.queryParameters['id'];
  return TodoView(id: id);
}),

// go to the route
locator<RouterService>().goTo(Path(name: '/todos?id=123'));

// configure the route in route_config.dart
RouteEntry(path: '/todos', builder: (key, routeData) {
  final todo = routeData.extra as Todo;
  return TodoView(id: todo.id, name: todo.name);
}),

// go to the route
locator<RouterService>().goTo(Path(name: '/todos', extra: Todo(id: '123', name: 'Test')));


class AuthService {
  AuthService({required RouterService routerService, required FirebaseAuth firebaseAuth})
      : _routerService = routerService, _firebaseAuth = firebaseAuth {
    // synchronous check of routing
    checkAuthState(firebaseAuth.currentUser?.uid);

    // listen to user state for routing
    firebaseAuth.authStateChanges().listen((User? user) {
      checkAuthState(user?.uid);
    });
  }

  void checkAuthState(String? uid) {
    if (uid == null) {
      routerService.replaceAll([
        Path(name: '/login'),
      ]);
    } else {
      routerService.replaceAll([
        Path(name: '/'),
      ]);
    }
  }
}
 */
