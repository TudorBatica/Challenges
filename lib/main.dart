import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dependencies_configuration.dart';
import 'presentation/core/root_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  configureDependencies();
  runApp(RootWidget());
}
