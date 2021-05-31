import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import '../../application/new_team/new_team_cubit.dart';
import '../common/base_form.dart';
import '../common/button_with_border.dart';

/// New team creation form
class NewTeamForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewTeamCubit, NewTeamState>(
      listenWhen: (previous, current) =>
          previous.userNotFound != current.userNotFound ||
          previous.status != current.status,
      listener: (context, state) {
        if (state.userNotFound) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text('No user found with this id.')));
          BlocProvider.of<NewTeamCubit>(context).resetUserNotFound();
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text('Team creation failed.')));
        }
        if (state.status.isSubmissionSuccess) {
          BlocProvider.of<AppCubit>(context).navigateTo(teamsRoute);
        }
      },
      buildWhen: (previous, current) => previous.members != current.members,
      builder: (context, state) {
        return Align(
          child: BaseForm(
            elements: _getColumnChildren(state, context),
          ),
        );
      },
    );
  }

  List<Widget> _getColumnChildren(NewTeamState state, BuildContext context) {
    final list = [
      Text(
        'Create a new team',
        style: Theme.of(context).textTheme.headline4,
      ),
      SizedBox(height: 45.0),
      _NameInput(),
      SizedBox(height: 25.0),
      _InviteMemberInput(),
      SizedBox(height: 15.0),
      _InviteButton(),
      SizedBox(height: 15.0)
    ];

    if (state.members.value.isEmpty) {
      list.addAll([
        Text('No members invited yet.'
            ' Invite some using the above field'),
        SizedBox(height: 15.0)
      ]);
    } else {
      list.addAll(state.members.value
          .map(
            (member) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                SelectableText(
                  member.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SelectableText(
                  member.id,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 15.0),
              ],
            ),
          )
          .toList());
    }
    list.add(_SubmitButton());
    return list;
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTeamCubit, NewTeamState>(
      buildWhen: (previous, current) => previous.nameInput != current.nameInput,
      builder: (context, state) {
        return TextField(
          onChanged: (name) => context.read<NewTeamCubit>().nameChanged(name),
          decoration: InputDecoration(
            labelText: 'team name',
            errorText:
                state.nameInput.invalid ? "Enter your team's name" : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InviteMemberInput extends StatelessWidget {
  const _InviteMemberInput({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTeamCubit, NewTeamState>(
      buildWhen: (previous, current) => previous.userId != current.userId,
      builder: (context, state) {
        return TextField(
          onChanged: (id) => context.read<NewTeamCubit>().userIdChanged(id),
          decoration: InputDecoration(
            labelText: 'invite members by their id '
                '(available on the profile page)',
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InviteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonWithBorder(
      text: 'INVITE',
      borderColor: Theme.of(context).primaryColor,
      textColor: Theme.of(context).primaryColor,
      onPressed: () =>
          BlocProvider.of<NewTeamCubit>(context).addMemberToInvitedList(),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTeamCubit, NewTeamState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ButtonWithBorder(
                text: 'CREATE TEAM',
                borderColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: state.status.isValidated
                    ? () => context
                        .read<NewTeamCubit>()
                        .createTeamAndInviteMembers(
                            context.read<AppCubit>().state.user.identity.id,
                            context.read<AppCubit>().state.user.profile!.name)
                    : null,
              );
      },
    );
  }
}
