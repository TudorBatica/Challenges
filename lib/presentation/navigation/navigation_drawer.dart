import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import 'navigation_item.dart';

/// Side drawer which displays the navbar items.
/// Should be used for mobile(narrow) screens.
class NavigationDrawer extends StatelessWidget {
  /// Constructor
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn =
        !BlocProvider.of<AppCubit>(context).state.user.identity.isAnonymous;

    final authRelatedNavigationItem = isUserLoggedIn
        ? NavigationItem(
            name: 'Profile',
            navigationPath: profileRoute,
            textColor: Colors.black,
            borderColor: Colors.white)
        : NavigationItem(
            name: 'Enter account',
            navigationPath: signUpRoute,
            textColor: Colors.black,
            borderColor: Colors.white);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 25.0),
          authRelatedNavigationItem,
          SizedBox(height: 20.0),
          Divider(),
          SizedBox(height: 20.0),
          NavigationItem(
            name: 'Challenges',
            navigationPath: challengesListRoute,
            textColor: Colors.black,
            borderColor: Colors.white,
          ),
          SizedBox(height: 15.0),
          NavigationItem(
            name: 'Teams',
            navigationPath: teamsRoute,
            textColor: Colors.black,
            borderColor: Colors.white,
          ),
          SizedBox(height: 15.0),
          NavigationItem(
            name: 'Host a challenge',
            navigationPath: hostChallengeRoute,
            textColor: Colors.black,
            borderColor: Colors.white,
          )
        ],
      ),
    );
  }
}
