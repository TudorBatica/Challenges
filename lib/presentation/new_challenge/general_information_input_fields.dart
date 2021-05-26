import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/new_challenge/new_challenge_cubit.dart';

class TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_titleInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().titleChanged(value),
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.title.invalid
                ? 'Give your challenge a memorable name'
                    ' (of at least 5 characters)'
                : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_descriptionInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().descriptionChanged(value),
          decoration: InputDecoration(
            labelText: 'Description (NOT the actual task)',
            errorText: state.description.invalid
                ? 'Enter a description of at least 10 characters '
                    'that offers some context about your challenge'
                : null,
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

class CategoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_categoryInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().categoryChanged(value),
          decoration: InputDecoration(
            labelText: 'Category',
            errorText: state.category.invalid ? 'Invalid category' : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
