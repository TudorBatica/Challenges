import 'package:challengesapp/presentation/teams/teams_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import '../common/button_with_border.dart';
import '../common/scaffold_with_background.dart';

/// Page with teams and invitations
class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      child: Align(
        alignment: Alignment.topCenter,
        child: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 25.0),
                  ButtonWithBorder(
                    text: 'CREATE A NEW TEAM',
                    borderColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white,
                    onPressed: () => BlocProvider.of<AppCubit>(context)
                        .navigateTo(newTeamRoute),
                  ),
                  SizedBox(height: 25.0),
                  TeamsAndInvitationsList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
