import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/challenge/challenge.dart';

/// Models the data required to build
/// a challenge details page
@immutable
class ChallengeState extends Equatable {
  /// Challenge does not exist in the db
  final bool notFound;

  /// The challenge model.
  /// [ChallengeTask] will be if it should not be displayed
  /// yet to the user.
  final Challenge? challenge;

  // ignore: public_member_api_docs
  const ChallengeState({this.notFound = false, this.challenge});

  @override
  List<Object?> get props => [notFound, challenge];

  // ignore: public_member_api_docs
  ChallengeState copyWith({
    bool? notFound,
    Challenge? challenge,
  }) {
    return ChallengeState(
      notFound: notFound ?? this.notFound,
      challenge: challenge ?? this.challenge,
    );
  }
}
