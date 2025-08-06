
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    log('🟢 Event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    log('🔁 Transition: $bloc');
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('❌ Error: $error');
    super.onError(bloc, error, stackTrace);
  }
}
