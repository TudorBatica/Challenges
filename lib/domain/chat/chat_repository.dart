import 'message.dart';

/// Sends and retrieves messages in realtime.
abstract class ChatRepository {
  /// Get the entire conversation in realtime
  Stream<List<Message>> listenToConversation(String teamId);

  /// Sends a message
  Future<void> sendMessage(String teamId, Message message);
}
