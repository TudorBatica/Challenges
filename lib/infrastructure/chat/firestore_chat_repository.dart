import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/chat/chat_repository.dart';
import '../../domain/chat/message.dart';
import '../../domain/common/json_serializer.dart';
import '../common/database_naming.dart';

/// [ChatRepository] implementation which uses Firebase Firestore
@LazySingleton(as: ChatRepository)
class FirestoreChatRepository implements ChatRepository {
  final JsonSerializer<Message> _serializer;
  final FirebaseFirestore _firebaseFirestore;

  // ignore: public_member_api_docs
  FirestoreChatRepository(this._serializer, this._firebaseFirestore);

  @override
  Stream<List<Message>> listenToConversation(String teamId) async* {
    await for (var conversationSnapshot in _firebaseFirestore
        .collection(chatCollectionPath(teamId))
        .snapshots()) {
      yield conversationSnapshot.docs
          .map((doc) => Message.fromJson(doc.data()))
          .toList();
    }
  }

  @override
  Future<void> sendMessage(String teamId, Message message) async {
    var messageMap = _serializer.toJson(message);
    messageMap.update('createdAt', (value) => FieldValue.serverTimestamp());
    await _firebaseFirestore
        .collection(chatCollectionPath(teamId))
        .add(messageMap);
  }
}
