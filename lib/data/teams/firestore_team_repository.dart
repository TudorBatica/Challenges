import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/common/json_serializer.dart';
import '../../domain/teams/team.dart';
import '../../domain/teams/team_repository.dart';
import '../common/database_naming.dart';
import '../common/firestore_crud_repository.dart';

/// [TeamRepository] implementation which uses Firebase Firestore
@LazySingleton(as: TeamRepository)
class FirestoreTeamRepository extends FirestoreCrudRepository<Team>
    implements TeamRepository {
  // ignore: public_member_api_docs
  FirestoreTeamRepository(
      FirebaseFirestore firebaseFirestore, JsonSerializer<Team> serializer)
      : super(firebaseFirestore, serializer, teamsCollectionPath);

  @override
  Future<Team> createTeam(Team team) async {
    final teamId = await create(team, null, writeIdInDoc: true);
    return team.copyWith(id: teamId);
  }

  @override
  Future<Team> retrieveTeam(String id) async {
    return await read(id);
  }

  @override
  Future<void> updateTeam(
      Map<String, dynamic> updatedFields, String teamId) async {
    await update(updatedFields, teamId);
  }
}
