import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../application/challenge/challenge_cubit.dart';
import '../../application/challenge/challenge_state.dart';
import '../common/scaffold_with_background.dart';

class ChallengePage extends StatelessWidget {
  /// Challenge id
  final String id;

  // ignore: public_member_api_docs
  ChallengePage({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChallengeCubit(buildContext: context, challengeId: id),
      child: ScaffoldWithBackground(child:
          BlocBuilder<ChallengeCubit, ChallengeState>(
              builder: (context, state) {
        if (state.notFound) {
          return Container(child: Text('challenge does not exist'));
        }
        return state.challenge == null
            ? Center(child: LoadingIndicator(indicatorType: Indicator.orbit))
            : Container(child: Text(state.challenge!.information.title));
      })),
    );
  }
}
