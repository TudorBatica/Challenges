import 'package:challengesapp/presentation/teams/team_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import '../common/base_form.dart';
import '../common/button_with_border.dart';
import '../common/scaffold_with_background.dart';

/// User profile page widget
class ProfilePage extends StatelessWidget {
  /// Constructor
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous.user != current.user,
        builder: (context, state) {
          return (state.user.identity.isAnonymous || state.user.profile == null)
              ? LoadingIndicator(indicatorType: Indicator.orbit)
              : Center(
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      minHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    decoration: BoxDecoration(color: Colors.white70),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.read<AppCubit>().logUserOut();
                                    context
                                        .read<AppCubit>()
                                        .navigateTo(challengesListRoute);
                                  },
                                  icon: Icon(Icons.logout),
                                ),
                                Expanded(
                                  child: Center(
                                    child: SelectableText(
                                      state.user.profile!.name,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            SelectableText(
                              state.user.identity.email.toString(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(height: 10.0),
                            SelectableText(
                              state.user.identity.id,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(height: 20.0),
                            ...state.user.profile!.teams!.map(
                              (team) => Column(
                                children: [
                                  TeamCard(teamInfo: team),
                                  SizedBox(height: 10.0)
                                ].toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
