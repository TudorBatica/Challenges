import 'dart:math';

import 'package:challengesapp/domain/challenge/challenge_task.dart';
import 'package:challengesapp/presentation/challenge/challenge_detail_section.dart';
import 'package:challengesapp/presentation/common/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
              ? Center(child: LoadingIndicator(indicatorType: Indicator.orbit))
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
                            _ChallengePresentationSection(
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
                            _TaskSection(
                              width: _imageWidth,
                              task: state.challenge?.task,
                            ),
                            SizedBox(
                              height: 7.5,
                            ),
                            _ScheduleSection(
                              width: _imageWidth,
                              registration:
                                  state.challenge!.information.registration,
                              start: state.challenge!.information.registration,
                              solutions:
                                  state.challenge!.information.submission,
                            ),
                            SizedBox(
                              height: 7.5,
                            ),
                            _TeamSizeSection(
                              width: _imageWidth,
                              minSize: state.challenge!.information.teamSizeMin,
                              maxSize: state.challenge!.information.teamSizeMax,
                            ),
                            SizedBox(
                              height: 7.5,
                            ),
                            _PrizeSection(
                              width: _imageWidth,
                              prize: state.challenge!.information.prize,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        }),
      ),
    );
  }
}

class _ChallengePresentationSection extends StatelessWidget {
  final double width;
  final String title;
  final String hostName;
  final String description;

  const _ChallengePresentationSection(
      {Key? key,
      required this.title,
      required this.description,
      required this.hostName,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.description),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(title,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black)),
          SelectableText('by $hostName',
              style: Theme.of(context).textTheme.headline6)
        ],
      ),
      content: SelectableText(description),
    );
  }
}

class _TaskSection extends StatelessWidget {
  final double width;
  final ChallengeTask? task;

  const _TaskSection({Key? key, required this.width, this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.lightbulb_outline),
      title: SelectableText('Your task',
          style: Theme.of(context).textTheme.headline5),
      content: (task == null)
          ? SelectableText('Task not yet available.')
          : SelectableText(task!.description),
    );
  }
}

class _ScheduleSection extends StatelessWidget {
  final double width;
  final DateTime registration;
  final DateTime start;
  final DateTime solutions;

  const _ScheduleSection(
      {Key? key,
      required this.width,
      required this.registration,
      required this.start,
      required this.solutions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.access_time),
      title: SelectableText('Schedule',
          style: Theme.of(context).textTheme.headline5),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText('Register until'),
          SelectableText(
            DateFormat('EEE, M/d/y').add_Hm().format(registration),
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 12.5),
          SelectableText('Challenge starts'),
          SelectableText(
            DateFormat('EEE, M/d/y').add_Hm().format(start),
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 12.5),
          SelectableText('Submit solutions until'),
          SelectableText(
            DateFormat('EEE, M/d/y').add_Hm().format(solutions),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

class _TeamSizeSection extends StatelessWidget {
  final double width;
  final int minSize;
  final int maxSize;

  const _TeamSizeSection(
      {Key? key,
      required this.width,
      required this.minSize,
      required this.maxSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.group),
      title: SelectableText('Team size',
          style: Theme.of(context).textTheme.headline5),
      content: SelectableText('Make teams of $minSize-$maxSize people'),
    );
  }
}

class _PrizeSection extends StatelessWidget {
  final double width;
  final String prize;

  const _PrizeSection({Key? key, required this.width, required this.prize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.monetization_on),
      title:
          SelectableText('Prize', style: Theme.of(context).textTheme.headline5),
      content: SelectableText(prize),
    );
  }
}
