import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import '../../domain/teams/team_basic_info.dart';

/// Displays a team
class TeamCard extends StatelessWidget {
  /// Team to display
  final TeamBasicInfo teamInfo;

  // ignore: public_member_api_docs
  const TeamCard({Key? key, required this.teamInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = min(500.0, MediaQuery.of(context).size.width).toDouble();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        onPressed: () => BlocProvider.of<AppCubit>(context)
            .navigateTo(chatRoute(teamInfo.id)),
        child: Container(
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
        ),
      ),
    );
  }
}
