import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/new_team/new_team_cubit.dart';
import '../../dependencies_configuration.dart';
import '../common/scaffold_with_background.dart';
import 'new_team_form.dart';

/// Page for creating a new team
class NewTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NewTeamCubit>(),
      child: ScaffoldWithBackground(child: NewTeamForm()),
    );
  }
}
