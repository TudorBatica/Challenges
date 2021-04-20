import 'package:challengesapp/dependencies_configuration.dart';
import 'package:challengesapp/presentation/core/root_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  configureDependencies();
  runApp(RootWidget());
}
