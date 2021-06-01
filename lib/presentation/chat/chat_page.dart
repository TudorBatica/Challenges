import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/chat/chat_cubit.dart';
import '../../application/common/app_cubit.dart';
import '../../dependencies_configuration.dart';
import '../../domain/chat/chat_repository.dart';
import '../../domain/teams/team_repository.dart';
import '../common/scaffold_with_background.dart';

/// Chat page of a team
class ChatPage extends StatelessWidget {
  final String teamId;

  // ignore: public_member_api_docs
  const ChatPage({Key? key, required this.teamId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            return Scaffold(
              appBar: AppBar(
                title: Text(teamId),
              ),
              backgroundColor: Colors.transparent,
              bottomNavigationBar: TextField(
                decoration:
                    InputDecoration(helperText: 'Type your message here'),
              ),
            );
          },
        ),
      ),
    );
  }
}
