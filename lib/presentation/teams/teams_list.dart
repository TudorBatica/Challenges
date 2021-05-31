import 'package:challengesapp/presentation/teams/invitation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../application/common/app_cubit.dart';

class TeamsAndInvitationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) =>
          previous.user.profile?.invitations !=
          current.user.profile?.invitations,
      builder: (context, state) => state.user.profile == null
          ? LoadingIndicator(indicatorType: Indicator.orbit)
          : _InvitationsList(),
    );
  }
}

class _InvitationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      final invitations = state.user.profile!.invitations;
      if (invitations == null || invitations.isEmpty) {
        return Container();
      }
      return Column(
        children: invitations
            .map((e) => InvitationCard(
                  team: e,
                ))
            .toList(),
      );
    });
  }
}
