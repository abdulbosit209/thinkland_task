import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:thinkland_task/config/locator_config.dart';

/// Represents different states of app initialization
sealed class AppState {
  const AppState();
}

class InitializingApp extends AppState {
  const InitializingApp();
}

class AppInitialized extends AppState {
  const AppInitialized();
}

class AppInitializationError extends AppState {
  final Object error;
  final StackTrace stackTrace;
  const AppInitializationError(this.error, this.stackTrace);
}

/// ViewModel responsible for handling app startup and initialization
class StartupViewModel {
  StartupViewModel();

  final appStateNotifier = ValueNotifier<AppState>(const InitializingApp());


  Future<void> initializeApp() async {
    appStateNotifier.value = const InitializingApp();
    try {
      setup();
      await locator.allReady();
      appStateNotifier.value = const AppInitialized();
    } catch (e, st) {
      appStateNotifier.value = AppInitializationError(e, st);
    }
  }

  Future<void> retryInitialization() async {
    locator.reset();
    await initializeApp();
  }

  void dispose() {
    appStateNotifier.dispose();
  }
}
