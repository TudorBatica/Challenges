import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'dependencies_configuration.dart';
import 'presentation/common/root_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  configureDependencies();
  setPathUrlStrategy(); // removes the `#` in the URLs
  runApp(RootWidget());
}
