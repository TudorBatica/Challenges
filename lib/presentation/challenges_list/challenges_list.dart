import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/challenges_list/challenges_list_cubit.dart';
import '../../application/challenges_list/challenges_list_state.dart';

class ChallengesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengesListCubit, ChallengesListState>(
      buildWhen: (previous, current) =>
          previous.challenges != current.challenges,
      builder: (context, state) => Container(
        child: state.challenges == null
            ? Text('nmc, ne incarcam')
            : Text(state.challenges!.length.toString()),
      ),
    );
  }
}
