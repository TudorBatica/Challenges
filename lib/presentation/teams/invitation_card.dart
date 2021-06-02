import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/teams/team.dart';
import '../common/button_with_border.dart';

/// Displays an invitation
class InvitationCard extends StatelessWidget {
  /// Team into which the user is invited
  final Team team;

  /// Accept invitation handler
  final void Function()? onAccept;

  /// Decline invitation handler
  final void Function()? onDecline;

  // ignore: public_member_api_docs
  InvitationCard({Key? key, required this.team, this.onAccept, this.onDecline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = min(500.0, MediaQuery.of(context).size.width).toDouble();
    var members = '';
    team.members.asMap().forEach((index, value) {
      members += value.name;
      if (index != team.members.length - 1) {
        members += ', ';
      }
    });
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color.fromRGBO(31, 29, 43, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              'You have been invited to team',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Color.fromRGBO(241, 241, 241, 1),
                    fontWeight: FontWeight.w100,
                  ),
            ),
            SizedBox(height: 12.5),
            SelectableText(
              team.name,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Color.fromRGBO(241, 241, 241, 1)),
            ),
            SizedBox(height: 12.5),
            Divider(color: Color.fromRGBO(241, 241, 241, 1)),
            SizedBox(height: 12.5),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.group,
                        color: Color.fromRGBO(241, 241, 241, 1)),
                  ),
                  TextSpan(
                    text: '     $members',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Color.fromRGBO(241, 241, 241, 0.7),
                        ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonWithBorder(
                  onPressed: onAccept,
                  text: 'ACCEPT',
                  borderColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                  textColor: Color.fromRGBO(31, 29, 43, 1),
                ),
                SizedBox(width: 20.0),
                ButtonWithBorder(
                  onPressed: onDecline,
                  text: 'DECLINE',
                  borderColor: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
