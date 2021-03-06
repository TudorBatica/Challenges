import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import '../../dependencies_configuration.dart';
import '../../domain/authentication/authentication_repository.dart';
import 'base_page.dart';

/// App's main widget wrap.
class RootWidget extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(getIt<AuthenticationRepository>(), _navigatorKey,
          getIt<FirebaseMessaging>()),
      child: Center(child: RootAppWidget(navigatorKey: _navigatorKey)),
    );
  }
}

/// App's main widget
class RootAppWidget extends StatelessWidget {
  /// Global navigation key used in the app
  final GlobalKey<NavigatorState> navigatorKey;

  // ignore: public_member_api_docs
  RootAppWidget({Key? key, required this.navigatorKey}) : super(key: key);

  /// Used for the primary swatch's luminance
  final Map<int, Color> primarySwatchColors = {
    50: Color.fromRGBO(104, 106, 197, .1),
    100: Color.fromRGBO(104, 106, 197, .2),
    200: Color.fromRGBO(104, 106, 197, .3),
    300: Color.fromRGBO(104, 106, 197, .4),
    400: Color.fromRGBO(104, 106, 197, .5),
    500: Color.fromRGBO(104, 106, 197, .6),
    600: Color.fromRGBO(104, 106, 197, .7),
    700: Color.fromRGBO(104, 106, 197, .8),
    800: Color.fromRGBO(104, 106, 197, .9),
    900: Color.fromRGBO(104, 106, 197, 1),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Challenges App',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            primarySwatch: //Colors.purple
                MaterialColor(0xFF686AC5, primarySwatchColors),
            textTheme: TextTheme(
              headline1: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              headline2: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              headline3: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              headline4: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              headline5: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              headline6: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              bodyText1: GoogleFonts.redHatText(fontWeight: FontWeight.w400),
              bodyText2: GoogleFonts.redHatText(fontWeight: FontWeight.w400),
              button: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              caption: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              overline: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              subtitle1: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
              subtitle2: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w600),
            ),
          ),
          builder: (context, child) => BasePage(child: child),
          navigatorKey: navigatorKey,
          onGenerateRoute: context.read<AppCubit>().generateRoute,
          initialRoute: challengesListRoute,
        );
      },
    );
  }
}
