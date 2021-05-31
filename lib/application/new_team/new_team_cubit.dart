import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/common/common_failures.dart';
import '../../domain/profile/profile_repository.dart';
import '../../domain/teams/team.dart';
import '../../domain/teams/team_basic_info.dart';
import '../../domain/teams/team_member.dart';
import '../../domain/teams/team_repository.dart';
import 'members_input.dart';
import 'team_name_input.dart';

part 'new_team_state.dart';

/// Manages the new team form state
@injectable
class NewTeamCubit extends Cubit<NewTeamState> {
  final TeamRepository _teamRepository;
  final ProfileRepository _profileRepository;

  // ignore: public_member_api_docs
  NewTeamCubit(this._profileRepository, this._teamRepository)
      : super(NewTeamState.intial());

  /// Update value from team name input
  void nameChanged(String value) {
    final name = TeamNameInput.dirty(value: value);
    emit(state.copyWith(
        nameInput: name, status: Formz.validate([name, state.members])));
  }

  /// Update value from invitation field
  void userIdChanged(String value) {
    emit(state.copyWith(userId: value));
  }

  /// Add member to the invited list.
  /// Updates state's [userNotFound] if the id
  /// does not correspond to any user
  void addMemberToInvitedList() async {
    try {
      final userToInvite =
          await _profileRepository.getUserProfile(state.userId);
      final updatedMembers = state.members.value;
      updatedMembers.add(TeamMember(name: userToInvite.name, id: state.userId));
      final membersInput = MembersInput.dirty(value: updatedMembers);
      emit(state.copyWith(
          members: membersInput,
          status: Formz.validate([membersInput, state.nameInput])));
    } on DataNotFound {
      emit(state.copyWith(userNotFound: true));
    }
  }

  /// Resets the user not found flag
  void resetUserNotFound() async {
    emit(state.copyWith(userNotFound: !state.userNotFound));
  }

  /// Creates the team, updates the logged in user's profile
  /// and send invitations to team members(by updating their profiles).
  Future<void> createTeamAndInviteMembers(
      String currentlyLoggedInUserId, String currentlyLoggedInUserName) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final team =
          await _createTeam(currentlyLoggedInUserId, currentlyLoggedInUserName);
      _addTeamToCurrentUserProfile(team, currentlyLoggedInUserId);
      _inviteMembers(team);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<Team> _createTeam(
      String currentlyLoggedInUserId, String currentlyLoggedInUserName) async {
    final members = state.members.value;
    members.add(TeamMember(
        id: currentlyLoggedInUserId, name: currentlyLoggedInUserName));
    return await _teamRepository.createTeam(
        Team(id: '', name: state.nameInput.value, members: members));
  }

  Future<void> _addTeamToCurrentUserProfile(
      Team team, String currentlyLoggedInUserId) async {
    await _profileRepository.updateUserProfile({
      'teams': FieldValue.arrayUnion(
          [TeamBasicInfo(id: team.id, name: team.name).toJson()])
    }, currentlyLoggedInUserId);
  }

  Future<void> _inviteMembers(Team team) async {
    for (final member in state.members.value) {
      await _profileRepository.updateUserProfile({
        'invitations': FieldValue.arrayUnion([team.toJson()])
      }, member.id);
    }
  }
}
