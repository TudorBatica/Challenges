import 'dart:math';

import 'package:challengesapp/domain/common/pair.dart';
import 'package:flutter/material.dart';

import '../../domain/challenge/challenge_info.dart';

class ChallengeCard extends StatelessWidget {
  final ChallengeInfo challengeInfo;

  const ChallengeCard({Key? key, required this.challengeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = min(MediaQuery.of(context).size.width, 400).toDouble();
    final _imageHeight = (_width * (9 / 16)).toDouble();
    final _textContainerHeigth = min(_imageHeight * 2, 300).toDouble();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        color: Colors.transparent,
        width: _width,
        height: _imageHeight + _textContainerHeigth,
        child: Column(
          children: [
            _ImageContainer(
              height: _imageHeight,
              imageURL: challengeInfo.imageURL,
              width: _width,
            ),
            _InformationContainer(
              challengeInfo: challengeInfo,
              height: _textContainerHeigth,
              width: _width,
            )
          ],
        ),
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  final double height;
  final String imageURL;
  final double width;

  const _ImageContainer(
      {Key? key,
      required this.height,
      required this.imageURL,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Image.network(
        imageURL,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _InformationContainer extends StatelessWidget {
  final ChallengeInfo challengeInfo;
  final double height;
  final double width;

  const _InformationContainer(
      {Key? key,
      required this.challengeInfo,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //SizedBox(height: min(10.0, height * 0.125)),
            _TitleContainer(height: height * 0.3, title: challengeInfo.title),
            Text(
              'by ${challengeInfo.challengeHostName}',
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            _DescriptionContainer(
                height: height * 0.3, description: challengeInfo.description),
            _AdditionalInformation(
                height: height * 0.3,
                teamSize:
                    Pair(challengeInfo.teamSizeMin, challengeInfo.teamSizeMax),
                registrationDeadline: challengeInfo.registration,
                startDatetime: challengeInfo.start,
                solutionSubmissionDeadline: challengeInfo.submission),
          ],
        ),
      ),
    );
  }
}

class _TitleContainer extends StatelessWidget {
  final double height;
  final String title;

  const _TitleContainer({Key? key, required this.height, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          maxLines: 2,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}

class _DescriptionContainer extends StatelessWidget {
  final double height;
  final String description;

  const _DescriptionContainer(
      {Key? key, required this.height, required this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          description,
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}

class _AdditionalInformation extends StatelessWidget {
  final double height;
  final Pair<int, int> teamSize;

  late final DateTime nextDeadline;
  late final String nextDeadlineMessage;

  _AdditionalInformation(
      {Key? key,
      required this.height,
      required this.teamSize,
      required DateTime registrationDeadline,
      required DateTime startDatetime,
      required DateTime solutionSubmissionDeadline})
      : super(key: key) {
    final now = DateTime.now();
    if (registrationDeadline.isAfter(now)) {
      nextDeadline = registrationDeadline;
      nextDeadlineMessage = ' registration deadline: ';
    } else if (startDatetime.isAfter(now)) {
      nextDeadline = startDatetime;
      nextDeadlineMessage = ' starts: ';
    } else {
      nextDeadline = solutionSubmissionDeadline;
      nextDeadlineMessage = ' submit solutions until: ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.people_alt_outlined),
                ),
                TextSpan(
                    text: 'team size: ',
                    style: Theme.of(context).textTheme.bodyText1),
                TextSpan(
                  text: '${teamSize.first}-${teamSize.second} people',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.access_time),
                ),
                TextSpan(
                    text: nextDeadlineMessage,
                    style: Theme.of(context).textTheme.bodyText2),
                TextSpan(
                  text: nextDeadline.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
