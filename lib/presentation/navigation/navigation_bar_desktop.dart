import 'package:challengesapp/application/common/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/navigation/route_names.dart';
import 'navigation_item.dart';

/// Navbar for wide screens. Displays the nav items on the bar itself.
class NavigationBarDesktop extends StatelessWidget {
  /// Constructor
  const NavigationBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = 66.5; // about 1.75 cm

    return Container(
      height: height,
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_MainNavElements(), _TrailingNavElements()],
        ),
      ),
    );
  }
}

class _MainNavElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Logos',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          width: 60,
        ),
        NavigationItem(
          name: 'CHALLENGES',
          navigationPath: challengesListRoute,
          textColor: Colors.black,
          borderColor: Colors.white,
        ),
        SizedBox(
          width: 35,
        ),
        NavigationItem(
          name: 'TEAMS',
          navigationPath: teamsRoute,
          textColor: Colors.black,
          borderColor: Colors.white,
        )
      ],
    );
  }
}

class _TrailingNavElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AccountButton(),
        SizedBox(
          width: 20,
        ),
        NavigationItem(
          name: 'HOST',
          navigationPath: hostChallengeRoute,
          textColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}

class _AccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) => state.user.identity.isAnonymous
          ? NavigationItem(
              name: 'ENTER ACCOUNT',
              navigationPath: signUpRoute,
              textColor: Colors.white,
              borderColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryColor,
            )
          : IconButton(
              onPressed: () =>
                  BlocProvider.of<AppCubit>(context).navigateTo(profileRoute),
              icon: (state.user.profile == null ||
                      state.user.profile!.profilePictureURL == null)
                  ? Icon(Icons.person)
                  : Image.network(
                      state.user.profile!.profilePictureURL.toString(),
                    ),
            ),
    );
  }
}
