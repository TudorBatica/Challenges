import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../application/challenges_list/challenges_list_cubit.dart';
import '../../application/challenges_list/challenges_list_state.dart';
import 'challenge_card.dart';

/// Widget which holds challenges.
class ChallengesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengesListCubit, ChallengesListState>(
      buildWhen: (previous, current) =>
          previous.challenges != current.challenges,
      builder: (context, state) => state.challenges == null
          ? Center(child: LoadingIndicator(indicatorType: Indicator.orbit))
          : Scrollbar(
              isAlwaysShown: true,
              child: Container(
                child: SingleChildScrollView(
                  child: ResponsiveGridRow(
                    children: state.challenges!
                        .map(
                          (chl) => ResponsiveGridCol(
                            lg: 4,
                            md: 6,
                            child: ChallengeCard(
                              challengeInfo: chl,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
    );
  }
}
