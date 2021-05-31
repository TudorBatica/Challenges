import 'dart:math';

import 'package:challengesapp/domain/teams/team_basic_info.dart';
import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final TeamBasicInfo teamInfo;

  const TeamCard({Key? key, required this.teamInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = min(500.0, MediaQuery.of(context).size.width).toDouble();
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.group, color: Colors.black),
              ),
              TextSpan(
                text: '     ${teamInfo.name}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
