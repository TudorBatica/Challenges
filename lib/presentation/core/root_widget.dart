import 'package:challengesapp/presentation/authentication/sign_in_page.dart';
import 'package:challengesapp/presentation/core/base_page.dart';
import 'package:challengesapp/presentation/home/home_page.dart';
import 'package:challengesapp/presentation/navigation/navigation_service.dart';
import 'package:challengesapp/presentation/navigation/route_names.dart';
import 'package:challengesapp/presentation/navigation/router.dart';
import 'package:challengesapp/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/core/app_cubit.dart';
import '../../dependencies_configuration.dart';

/// App's main widget.
class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppCubit>(),
      child: MaterialApp(
        title: 'Flutter Demo',
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
