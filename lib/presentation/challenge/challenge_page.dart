import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../application/challenge/challenge_cubit.dart';
import '../common/image_container.dart';
import '../common/scaffold_with_background.dart';
import 'challenge_page_sections.dart';

/// Challenge details page
class ChallengePage extends StatelessWidget {
  /// Challenge id
  final String id;

  // ignore: public_member_api_docs
  ChallengePage({required this.id});

  @override
  Widget build(BuildContext context) {
    final _imageWidth = min(MediaQuery.of(context).size.width, 700).toDouble();
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
                ? Center(
                    child: LoadingIndicator(indicatorType: Indicator.orbit))
                : Center(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageContainer(
                                height: _imageHeight,
                                imageURL: state.challenge!.information.imageURL,
                                width: _imageWidth,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              ChallengePresentationSection(
                                title: state.challenge!.information.title,
                                description:
                                    state.challenge!.information.description,
                                hostName: state
                                    .challenge!.information.challengeHostName,
                                width: _imageWidth,
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              TaskSection(
                                width: _imageWidth,
                                task: state.challenge?.task,
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              ScheduleSection(
                                width: _imageWidth,
                                registration:
                                    state.challenge!.information.registration,
                                start:
                                    state.challenge!.information.registration,
                                solutions:
                                    state.challenge!.information.submission,
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              TeamSizeSection(
                                width: _imageWidth,
                                minSize:
                                    state.challenge!.information.teamSizeMin,
                                maxSize:
                                    state.challenge!.information.teamSizeMax,
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              PrizeSection(
                                width: _imageWidth,
                                prize: state.challenge!.information.prize,
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              state.shouldDisplayRegistrationSection
                                  ? RegistrationSection(width: _imageWidth)
                                  : Container(),
                              SizedBox(
                                height: 7.5,
                              ),
                              RegisteredTeamsList(
                                width: _imageWidth,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
