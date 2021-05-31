import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../application/challenge/challenge_cubit.dart';
import '../../application/challenge/challenge_state.dart';
import '../common/scaffold_with_background.dart';

/// Challenge details page
class ChallengePage extends StatelessWidget {
  /// Challenge id
  final String id;

  // ignore: public_member_api_docs
  ChallengePage({required this.id});

  @override
  Widget build(BuildContext context) {
    final _imageWidth = min(MediaQuery.of(context).size.width, 400).toDouble();
    final _imageHeight = (_imageWidth * (9 / 16)).toDouble();

    return BlocProvider(
      create: (context) =>
          ChallengeCubit(buildContext: context, challengeId: id),
      child: ScaffoldWithBackground(
        child: BlocBuilder<ChallengeCubit, ChallengeState>(
            builder: (context, state) {
          if (state.notFound) {
            return Container(child: Text('challenge does not exist'));
          }
          return state.challenge == null
              ? Center(child: LoadingIndicator(indicatorType: Indicator.orbit))
              : Container(
                  child: Column(
                  children: [Container()],
                ));
        }),
      ),
    );
  }
}
