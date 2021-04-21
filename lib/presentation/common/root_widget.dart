import 'package:challengesapp/application/common/app_cubit.dart';
import 'package:challengesapp/application/navigation/navigation_service.dart';
import 'package:challengesapp/presentation/authentication/sign_in_page.dart';
import 'package:challengesapp/presentation/home/home_page.dart';
import 'package:challengesapp/application/navigation/navigation_service_impl.dart';
import 'package:challengesapp/application/navigation/route_names.dart';
import 'package:challengesapp/application/navigation/router.dart';
import 'package:challengesapp/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependencies_configuration.dart';
import 'base_page.dart';

/// App's main widget.
class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppCubit>(),
      child: MaterialApp(
        title: 'Challenges App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) => BasePage(child: child),
        navigatorKey: getIt<NavigationService>().navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: profileRoute,
      ),
    );
  }
}
