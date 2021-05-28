import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../application/challenges_list/challenges_list_cubit.dart';
import '../../application/challenges_list/challenges_list_state.dart';
import 'challenge_card.dart';

class ChallengesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengesListCubit, ChallengesListState>(
      buildWhen: (previous, current) =>
          previous.challenges != current.challenges,
      builder: (context, state) => Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Container(
            child: state.challenges == null
                ? Center(
                    child: LoadingIndicator(indicatorType: Indicator.orbit))
                : ResponsiveGridRow(
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
