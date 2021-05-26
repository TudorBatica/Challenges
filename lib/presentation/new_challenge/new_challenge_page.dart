import 'package:challengesapp/presentation/new_challenge/new_challenge_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/new_challenge/new_challenge_cubit.dart';
import '../../dependencies_configuration.dart';

class NewChallengePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<NewChallengeCubit>(),
        child: NewChallengeForm(),
      ),
    );
  }
}
