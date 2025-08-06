import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart' show configureUrlStrategy;
import 'package:thinkland_task/startup/start_up_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureUrlStrategy();

  runApp(const StartupView());
}
