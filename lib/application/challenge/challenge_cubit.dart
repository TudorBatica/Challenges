import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../dependencies_configuration.dart';
import '../../domain/challenge/challenge.dart';
import '../../domain/challenge/challenge_info.dart';
import '../../domain/challenge/challenge_repository.dart';
import '../../domain/challenge/challenge_task.dart';
import '../../domain/common/common_failures.dart';
import '../../domain/common/user.dart';
import '../../domain/profile/profile_repository.dart';
import '../../domain/teams/team.dart';
import '../../domain/teams/team_basic_info.dart';
import '../../domain/teams/team_repository.dart';
import '../common/app_cubit.dart';

part 'challenge_state.dart';

/// Manages the state of a details page of a challenge.
class ChallengeCubit extends Cubit<ChallengeState> {
  /// The current build context
  final BuildContext buildContext;

  /// Challenge's id
  final String challengeId;
  late final ChallengeRepository _challengeRepository;
  late final ProfileRepository _profileRepository;
  late final TeamRepository _teamRepository;

  // ignore: public_member_api_docs
  ChallengeCubit({required this.buildContext, required this.challengeId})
      : super(const ChallengeState()) {
    _challengeRepository = getIt<ChallengeRepository>();
    _profileRepository = getIt<ProfileRepository>();
    _teamRepository = getIt<TeamRepository>();
    _emitInitialState();
    print(state.registrationStatus);
  }

  /// Handle new input inside the registration textfield
  void registrationInputChanged(String value) async {
    if (value.length > 1) {
      emit(state.copyWith(
          registrationStatus: FormzStatus.valid, registrationInput: value));
    } else {
      emit(state.copyWith(
          registrationStatus: FormzStatus.invalid, registrationInput: value));
    }
  }

  /// Register team
  Future<void> registerTeam() async {
    try {
      emit(
          state.copyWith(registrationStatus: FormzStatus.submissionInProgress));
      await _addTeamToChallengeAndEmitState();
    } on DataNotFound {
      emit(state.copyWith(registrationStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> _addTeamToChallengeAndEmitState() async {
    print("looking for ${state.registrationInput.toString()}");
    final teamToRegister =
        await _teamRepository.retrieveTeam(state.registrationInput.toString());
    if (!_teamSizeIsEligible(teamToRegister)) {
      emit(state.copyWith(registrationStatus: FormzStatus.submissionFailure));
      return;
    }
    await _updateChallengeInfoWithNewTeam(teamToRegister);
    emit(state.copyWith(registrationStatus: FormzStatus.submissionSuccess));
  }

  Future<void> _updateChallengeInfoWithNewTeam(Team teamToRegister) async {
    await _challengeRepository
        .updateChallengeInfo(state.challenge!.information.id, {
      'registeredTeams': FieldValue.arrayUnion([
        TeamBasicInfo(id: teamToRegister.id, name: teamToRegister.name).toJson()
      ])
    });
  }

  bool _teamSizeIsEligible(Team teamToRegister) {
    return teamToRegister.members.length >=
            state.challenge!.information.teamSizeMin &&
        teamToRegister.members.length <=
            state.challenge!.information.teamSizeMax;
  }

  Future<void> _emitInitialState() async {
    try {
      final currentUser = BlocProvider.of<AppCubit>(buildContext).state.user;
      final challenge = await _retrieveChallenge(currentUser);
      emit(_getInitialState(currentUser, challenge));
    } on DataNotFound {
      emit(state.copyWith(notFound: true));
    }
  }

  Future<Challenge> _retrieveChallenge(User currentUser) async {
    final info = await _challengeRepository.getChallengeInfo(challengeId);
    final task =
        await _retrieveChallengeTaskIfShouldBeDisplayed(currentUser, info);
    return Challenge(information: info, task: task);
  }

  ChallengeState _getInitialState(User currentUser, Challenge challenge) {
    return ChallengeState(
      challenge: challenge,
      notFound: false,
      shouldDisplayRegistrationSection: _shouldDisplayRegistrationSection(
        currentUser,
        challenge.information,
      ),
      shouldDisplaySubmitSection: _shouldDisplaySubmitSection(
        currentUser,
        challenge.information,
      ),
    );
  }

  Future<ChallengeTask?> _retrieveChallengeTaskIfShouldBeDisplayed(
      User currentUser, ChallengeInfo info) async {
    if (_shouldRetrieveChallengeTask(currentUser, info)) {
      return await _challengeRepository.getChallengeTask(challengeId);
    }
  }

  bool _shouldRetrieveChallengeTask(User currentUser, ChallengeInfo info) {
    return currentUser.identity.id == info.challengeHostId ||
        DateTime.now().isBefore(info.start);
  }

  bool _shouldDisplayRegistrationSection(User currentUser, ChallengeInfo info) {
    return (currentUser.identity.isAnonymous ||
            info.registration.isBefore(DateTime.now()) ||
            _userIsInARegisteredTeam(currentUser, info))
        ? false
        : true;
  }

  bool _shouldDisplaySubmitSection(User currentUser, ChallengeInfo info) {
    return (currentUser.identity.isAnonymous ||
            !_userIsInARegisteredTeam(currentUser, info) ||
            info.submission.isBefore(DateTime.now()) ||
            info.start.isAfter(DateTime.now()))
        ? false
        : true;
  }

  bool _userIsInARegisteredTeam(User currentUser, ChallengeInfo info) {
    if (currentUser.profile!.teams == null || info.registeredTeams == null) {
      return false;
    }
    if (info.registeredTeams!
        .any((team) => currentUser.profile!.teams!.contains(team))) {
      return true;
    }
    return false;
  }
}
