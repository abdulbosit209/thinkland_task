// url_strategy_web.dart (used on web only)
import 'package:flutter_web_plugins/url_strategy.dart';

void configureUrlStrategy() {
  setUrlStrategy(const PathUrlStrategy());
}
