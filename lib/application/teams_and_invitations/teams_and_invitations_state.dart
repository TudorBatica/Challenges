part of 'teams_and_invitations_cubit.dart';

@immutable
class TeamsAndInvitationsState extends Equatable {
  final List<TeamBasicInfo>? teams;
  final List<Team>? invitations;

  const TeamsAndInvitationsState({this.teams, this.invitations});

  @override
  List<Object?> get props => [teams, invitations];

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
