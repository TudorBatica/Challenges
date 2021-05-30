import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import '../../application/navigation/router.dart';
import '../../dependencies_configuration.dart';
import '../../domain/authentication/authentication_repository.dart';
import 'base_page.dart';

/// App's main widget.
class RootWidget extends StatelessWidget {
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

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(getIt<AuthenticationRepository>(), _navigatorKey),
      child: MaterialApp(
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
        navigatorKey: _navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: profileRoute,
      ),
    );
  }
}
