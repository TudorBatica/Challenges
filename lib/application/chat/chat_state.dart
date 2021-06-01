part of 'chat_cubit.dart';

/// Models the challenge list state
@immutable
class ChatState extends Equatable {
  /// All the information about the team
  final Team? team;

  /// The list challenge infos
  final List<Message>? messages;

  /// True if the team is not in the database
  final bool teamDoesNotExist;

  /// Tru if the user is not in this team
  final bool userIsNotInTeam;

  // ignore: public_member_api_docs
  const ChatState({
    this.messages,
    this.team,
    this.teamDoesNotExist = false,
    this.userIsNotInTeam = false,
  });

  @override
  List<Object?> get props =>
      [messages, team, teamDoesNotExist, userIsNotInTeam];

  // ignore: public_member_api_docs
  ChatState copyWith({
    List<Message>? messages,
    Team? team,
    bool? teamDoesNotExist,
    bool? userIsNotInTeam,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      team: team ?? this.team,
      teamDoesNotExist: teamDoesNotExist ?? this.teamDoesNotExist,
      userIsNotInTeam: userIsNotInTeam ?? this.userIsNotInTeam,
    );
  }
}
