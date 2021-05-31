import 'package:challengesapp/domain/teams/team.dart';

/// Repo which manages teams
abstract class TeamRepository {
  /// Creates a new team
  Future<void> createTeam(Team team, String? id);

  /// Add a team member into a team
  Future<String> addTeamMember(String teamId, String member);

  /// Returns all information available about a team
  Future<Team> retrieveTeam(String id);
}
