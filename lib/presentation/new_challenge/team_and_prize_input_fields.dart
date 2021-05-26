import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/new_challenge/new_challenge_cubit.dart';
import '../../domain/common/pair.dart';

class PrizeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.prize != current.prize,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_prizeInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().prizeChanged(value),
          decoration: InputDecoration(
            labelText: 'Prize',
            errorText: state.prize.invalid ? 'Describe your prize' : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          maxLines: null,
        );
      },
    );
  }
}

class TeamSizeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.teamSize != current.teamSize,
      builder: (context, state) => RangeSlider(
        values: RangeValues(state.teamSize.value.first.toDouble(),
            state.teamSize.value.second.toDouble()),
        max: 15,
        min: 2,
        divisions: 13,
        labels: RangeLabels(state.teamSize.value.first.toString(),
            state.teamSize.value.second.toString()),
        onChanged: (value) => context
            .read<NewChallengeCubit>()
            .teamSizeChanged(Pair(value.start.toInt(), value.end.toInt())),
      ),
    );
  }
}
