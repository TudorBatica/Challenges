import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/profile/profile_repository.dart';
import '../../domain/profile/user_profile.dart';
import '../../domain/teams/team.dart';
import '../../domain/teams/team_basic_info.dart';
import '../../domain/teams/team_member.dart';
import '../../domain/teams/team_repository.dart';

part 'teams_and_invitations_state.dart';

/// Manages the teams and invitations list state.
class TeamsAndInvitationsCubit extends Cubit<TeamsAndInvitationsState> {
  final ProfileRepository _profileRepository;
  final TeamRepository _teamRepository;
  final String _currentlyLoggedInUserId;
  late UserProfile _userProfile;

  // ignore: public_member_api_docs
  TeamsAndInvitationsCubit(this._currentlyLoggedInUserId,
      this._profileRepository, this._teamRepository)
      : super(TeamsAndInvitationsState()) {
    _retrieveCurrentUserProfileAndUpdateState();
  }

  Future<void> _retrieveCurrentUserProfileAndUpdateState() async {
    _userProfile =
        await _profileRepository.getUserProfile(_currentlyLoggedInUserId);
    emit(state.copyWith(
        invitations: _userProfile.invitations ?? [],
        teams: _userProfile.teams ?? []));
  }

  /// User accepted the invitation
  Future<void> invitationAccepted(Team teamInvitedTo) async {
    await _addTeamToUserProfile(teamInvitedTo);
    await _addCurrentUserToTeam(teamInvitedTo);
    await _removeInvitationFromUserProfile(teamInvitedTo);
    await _retrieveCurrentUserProfileAndUpdateState();
  }

  /// User declined the invitation
  Future<void> invitationDeclined(Team teamInvitedTo) async {
    await _removeInvitationFromUserProfile(teamInvitedTo);
    await _retrieveCurrentUserProfileAndUpdateState();
  }

  Future<void> _addTeamToUserProfile(Team team) async {
    await _profileRepository.updateUserProfile({
      'teams': FieldValue.arrayUnion(
          [TeamBasicInfo(id: team.id, name: team.name).toJson()])
    }, _currentlyLoggedInUserId);
  }

  Future<void> _addCurrentUserToTeam(Team team) async {
    await _teamRepository.updateTeam({
      'members': FieldValue.arrayUnion([
        TeamMember(id: _currentlyLoggedInUserId, name: _userProfile.name)
            .toJson()
      ])
    }, team.id);
  }

  Future<void> _removeInvitationFromUserProfile(Team teamInvitedTo) async {
    await _profileRepository.updateUserProfile({
      'invitations': FieldValue.arrayRemove([teamInvitedTo.toJson()])
    }, _currentlyLoggedInUserId);
  }
}
