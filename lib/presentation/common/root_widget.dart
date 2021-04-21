import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/navigation_service.dart';
import '../../application/navigation/route_names.dart';
import '../../application/navigation/router.dart';
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
