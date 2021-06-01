import 'team.dart';

/// Repo which manages teams
abstract class TeamRepository {
  /// Creates a new team and returns the created entity
  Future<Team> createTeam(Team team);

  /// Update specific fields of a team
  Future<void> updateTeam(Map<String, dynamic> updatedFields, String teamId);

  /// Returns all information available about a team
  Future<Team> retrieveTeam(String id);
}
