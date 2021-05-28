import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/challenges_list/challenges_list_cubit.dart';
import '../../dependencies_configuration.dart';
import '../common/scaffold_with_background.dart';
import 'challenges_list.dart';

/// A page which displays the challenges.
class ChallengesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
        child: BlocProvider(
      create: (context) => getIt<ChallengesListCubit>(),
      child: Center(
        child: ChallengesList(),
      ),
    ));
  }
}
