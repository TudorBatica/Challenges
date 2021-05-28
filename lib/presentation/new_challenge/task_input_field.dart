import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/new_challenge/new_challenge_cubit.dart';

// ignore_for_file: public_member_api_docs

class TaskInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.task != current.task,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_taskInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().taskChanged(value),
          decoration: InputDecoration(
            labelText: 'Task',
            errorText: state.task.invalid ? 'invalid task' : null,
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
