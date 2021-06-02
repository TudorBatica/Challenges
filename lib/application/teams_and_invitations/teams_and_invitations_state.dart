part of 'teams_and_invitations_cubit.dart';

///
@immutable
class TeamsAndInvitationsState extends Equatable {
  /// User's teams
  final List<TeamBasicInfo>? teams;

  /// User's invitations
  final List<Team>? invitations;

  // ignore: public_member_api_docs
  const TeamsAndInvitationsState({this.teams, this.invitations});

  @override
  List<Object?> get props => [teams, invitations];

  // ignore: public_member_api_docs
  TeamsAndInvitationsState copyWith({
    List<TeamBasicInfo>? teams,
    List<Team>? invitations,
  }) {
    return TeamsAndInvitationsState(
      teams: teams ?? this.teams,
      invitations: invitations ?? this.invitations,
    );
  }
}
