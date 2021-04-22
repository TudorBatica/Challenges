import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dependencies_configuration.dart';
import 'presentation/common/root_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  configureDependencies();
  //setUrlStrategy(PathUrlStrategy()); Is bugged for some unknown reason
  runApp(RootWidget());
}
