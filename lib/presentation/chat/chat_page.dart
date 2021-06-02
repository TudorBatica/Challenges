import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../application/chat/chat_cubit.dart';
import '../../application/common/app_cubit.dart';
import '../../dependencies_configuration.dart';
import '../../domain/chat/chat_repository.dart';
import '../../domain/chat/message.dart';
import '../../domain/teams/team_member.dart';
import '../../domain/teams/team_repository.dart';
import '../common/scaffold_with_background.dart';
import 'message_container.dart';

/// Chat page of a team
class ChatPage extends StatelessWidget {
  /// Team's id
  final String teamId;

  // ignore: public_member_api_docs
  const ChatPage({Key? key, required this.teamId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    final focusNode = FocusNode();
    return ScaffoldWithBackground(
      child: BlocProvider(
        create: (context) => ChatCubit(
          getIt<ChatRepository>(),
          getIt<TeamRepository>(),
          teamId,
          BlocProvider.of<AppCubit>(context).state.user.identity.id,
        ),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state.userIsNotInTeam) {
              return Text('Access Denied');
            }
            if (state.teamDoesNotExist) {
              return Text('We could not find this chat.');
            }
            if (state.team == null) {
              return LoadingIndicator(indicatorType: Indicator.orbit);
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(state.team!.name),
              ),
              body: (state.messages == null)
                  ? LoadingIndicator(indicatorType: Indicator.orbit)
                  : ((state.messages!.isEmpty)
                      ? Center(
                          child: Text(
                          'No messages here.',
                          style: Theme.of(context).textTheme.headline6,
                        ))
                      : _MessagesList(
                          messages: state.messages,
                          members: state.team!.members,
                        )),
              backgroundColor: Colors.transparent,
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textFieldController,
                  focusNode: focusNode,
                  onSubmitted: (value) {
                    if (value.isEmpty) {
                      return;
                    }
                    context.read<ChatCubit>().sendMessage(value);
                    textFieldController.clear();
                    focusNode.requestFocus();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    hintText: 'Type your message here',
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MessagesList extends StatelessWidget {
  final List<Message>? messages;
  final List<TeamMember> members;

  const _MessagesList({Key? key, required this.messages, required this.members})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: _messagesToWidgets(context),
        ),
      ),
    ));
  }

  List<Widget> _messagesToWidgets(BuildContext context) {
    final currentUser = BlocProvider.of<AppCubit>(context).state.user;
    return messages!
        .map(
          (message) => message.sender == currentUser.identity.id
              ? MessageContainer.messageFromCurrentUser(
                  content: message.content,
                  createdAt: message.createdAt,
                  senderName: 'You',
                )
              : MessageContainer.messageFromOtherUser(
                  senderName: members
                      .firstWhere((element) => element.id == message.sender)
                      .name,
                  createdAt: message.createdAt,
                  content: message.content,
                ),
        )
        .toList();
  }
}
