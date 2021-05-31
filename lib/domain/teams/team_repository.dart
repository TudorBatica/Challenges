import 'package:challengesapp/domain/teams/team.dart';
import 'package:challengesapp/domain/teams/team_member.dart';

/// Repo which manages teams
abstract class TeamRepository {
  /// Creates a new team and returns the created entity
  Future<Team> createTeam(Team team);

  /// Add a team member into a team
  Future<void> addTeamMember(String teamId, TeamMember member);

  /// Returns all information available about a team
  Future<Team> retrieveTeam(String id);
}
