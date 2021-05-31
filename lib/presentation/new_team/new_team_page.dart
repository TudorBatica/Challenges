import 'package:challengesapp/application/new_team/new_team_cubit.dart';
import 'package:challengesapp/presentation/common/scaffold_with_background.dart';
import 'package:challengesapp/presentation/new_team/new_team_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependencies_configuration.dart';

class NewTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NewTeamCubit>(),
      child: ScaffoldWithBackground(child: NewTeamForm()),
    );
  }
}
