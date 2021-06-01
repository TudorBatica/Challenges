import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../application/teams_and_invitations/teams_and_invitations_cubit.dart';
import 'invitation_card.dart';
import 'team_card.dart';

class TeamsAndInvitationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_InvitationsList(), SizedBox(height: 25.0), _TeamsList()],
    );
  }
}

class _InvitationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsAndInvitationsCubit, TeamsAndInvitationsState>(
      buildWhen: (previous, current) =>
          previous.invitations != current.invitations,
      builder: (context, state) {
        final invitations = state.invitations;
        if (invitations == null) {
          return SizedBox(
              height: 100.0,
              width: 100.0,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Loading invitations')
                ],
              ));
        }
        if (invitations.isEmpty) {
          return Container();
        }
        return Column(
          children: invitations
              .map(
                (e) => InvitationCard(
                    team: e,
                    onAccept: () => context
                        .read<TeamsAndInvitationsCubit>()
                        .invitationAccepted(e),
                    onDecline: () => context
                        .read<TeamsAndInvitationsCubit>()
                        .invitationDeclined(e)),
              )
              .toList(),
        );
      },
    );
  }
}

class _TeamsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsAndInvitationsCubit, TeamsAndInvitationsState>(
      buildWhen: (previous, current) => previous.teams != current.teams,
      builder: (context, state) {
        final teams = state.teams;
        if (teams == null) {
          return SizedBox(
            height: 100.0,
            width: 100.0,
            child: Column(
              children: [CircularProgressIndicator(), Text('Loading teams')],
            ),
          );
        }
        if (teams.isEmpty) {
          return Container();
        }
        return Column(
          children: teams.map((e) => TeamCard(teamInfo: e)).toList(),
        );
      },
    );
  }
}
