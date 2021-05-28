import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../domain/challenge/challenge_info.dart';
import '../../domain/common/pair.dart';

class ChallengeCard extends StatelessWidget {
  final ChallengeInfo challengeInfo;

  const ChallengeCard({Key? key, required this.challengeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = min(MediaQuery.of(context).size.width, 400).toDouble();
    final _imageHeight = (_width * (9 / 16)).toDouble();
    final _textContainerHeigth = min(_imageHeight * 2, 300).toDouble();

    return MaterialButton(
      onPressed: () => print('c'),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Container(
          width: _width,
          height: _imageHeight + _textContainerHeigth,
          decoration: BoxDecoration(color: Colors.transparent),
          child: Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: CachedNetworkImage(
          imageUrl: imageURL,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress))),
        ),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
          maxLines: 4,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}

class _AdditionalInformation extends StatelessWidget {
  final double height;
  final Pair<int, int> teamSize;

  late final String nextDeadline;
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
      nextDeadline = Jiffy(registrationDeadline).fromNow();
      nextDeadlineMessage = ' registration deadline: ';
    } else if (startDatetime.isAfter(now)) {
      nextDeadline = Jiffy(startDatetime).fromNow();
      nextDeadlineMessage = ' starts: ';
    } else if (solutionSubmissionDeadline.isAfter(now)) {
      nextDeadline = Jiffy(solutionSubmissionDeadline).fromNow();
      nextDeadlineMessage = ' submit solutions: ';
    } else {
      nextDeadline = Jiffy(registrationDeadline).fromNow();
      nextDeadlineMessage = 'challenge ended: ';
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
