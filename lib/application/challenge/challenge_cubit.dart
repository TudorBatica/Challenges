import 'package:challengesapp/application/common/app_cubit.dart';
import 'package:challengesapp/domain/challenge/challenge.dart';
import 'package:challengesapp/domain/common/common_failures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../dependencies_configuration.dart';
import '../../domain/challenge/challenge_repository.dart';
import 'challenge_state.dart';

/// Manages the state of a details page of a challenge.
class ChallengeCubit extends Cubit<ChallengeState> {
  /// The current build context; used to retrieve
  /// the currently logged in user
  final BuildContext buildContext;

  /// Challenge's id
  final String challengeId;
  late final ChallengeRepository _challengeRepository;

  // ignore: public_member_api_docs
  ChallengeCubit({required this.buildContext, required this.challengeId})
      : super(const ChallengeState()) {
    _challengeRepository = getIt<ChallengeRepository>();
    _retrieveChallenge();
  }

  Future<void> _retrieveChallenge() async {
    try {
      final info = await _challengeRepository.getChallengeInfo(challengeId);
      final currentUser = BlocProvider.of<AppCubit>(buildContext).state.user;

      // If the user is not the host and the task should not be
      // shown yet, return just the challenge information.
      if (currentUser.identity.id != info.challengeHostId &&
          DateTime.now().isBefore(info.start)) {
        emit(state.copyWith(
            challenge: Challenge(information: info, task: null)));
        return;
      }

      final task = await _challengeRepository.getChallengeTask(challengeId);
      emit(state.copyWith(challenge: Challenge(information: info, task: task)));
    } on DataNotFound {
      emit(state.copyWith(notFound: true));
    }
  }
}
