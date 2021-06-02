import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/chat/chat_repository.dart';
import '../../domain/chat/message.dart';
import '../../domain/common/common_failures.dart';
import '../../domain/teams/team.dart';
import '../../domain/teams/team_member.dart';
import '../../domain/teams/team_repository.dart';

part 'chat_state.dart';

/// Manages chat's state
@injectable
class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  final TeamRepository _teamRepository;
  final String _teamId;
  final String _currentlyLoggedInUserId;
  StreamSubscription<List<Message>>? _conversationSubscription;

  /// Creates the chat cubit and starts listening to the chat messages
  /// of the given team
  ChatCubit(this._chatRepository, this._teamRepository, this._teamId,
      this._currentlyLoggedInUserId)
      : super(const ChatState()) {
    _initializeCubitAndUpdateStateAccordingly();
  }

  /// Sends a text message from the current user
  Future<void> sendMessage(String textMessage) async {
    final message = Message(
      content: textMessage,
      createdAt: DateTime.now(),
      sender: _currentlyLoggedInUserId,
    );
    await _chatRepository.sendMessage(_teamId, message);
  }

  Future<void> _initializeCubitAndUpdateStateAccordingly() async {
    final team = await _retrieveTeam();
    if (team == null) {
      emit(state.copyWith(teamDoesNotExist: true));
      return;
    }
    if (!_currentUserIsInTeam(team.members)) {
      emit(state.copyWith(userIsNotInTeam: true));
      return;
    }
    emit(state.copyWith(team: team));
    _startListeningConversation();
  }

  Future<Team?> _retrieveTeam() async {
    try {
      return await _teamRepository.retrieveTeam(_teamId);
    } on DataNotFound {
      return null;
    }
  }

  bool _currentUserIsInTeam(List<TeamMember> members) {
    for (final member in members) {
      if (member.id == _currentlyLoggedInUserId) {
        return true;
      }
    }
    return false;
  }

  void _startListeningConversation() {
    _conversationSubscription = _chatRepository
        .listenToConversation(_teamId)
        .listen((conversation) => emit(state.copyWith(messages: conversation)));
  }

  @override
  Future<void> close() {
    if (_conversationSubscription != null) {
      _conversationSubscription?.cancel();
    }
    return super.close();
  }
}
