import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/challenge/challenge_info.dart';

/// Models the challenge list state
@immutable
class ChallengesListState extends Equatable {
  /// The list challenge infos
  final List<ChallengeInfo>? challenges;

  // ignore: public_member_api_docs
  const ChallengesListState({this.challenges});

  @override
  // TODO: implement props
  List<Object?> get props => [challenges];

  // ignore: public_member_api_docs
  ChallengesListState copyWith({
    List<ChallengeInfo>? challenges,
  }) {
    return ChallengesListState(
      challenges: challenges ?? this.challenges,
    );
  }
}
