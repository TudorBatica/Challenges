import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/new_challenge/new_challenge_cubit.dart';
import '../../dependencies_configuration.dart';
import '../common/scaffold_with_background.dart';
import 'new_challenge_form.dart';

/// Page for creating a new challenge
class NewChallengePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      child: BlocProvider(
        create: (_) => getIt<NewChallengeCubit>(),
        child: NewChallengeForm(),
      ),
    );
  }
}
