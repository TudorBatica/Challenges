import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../application/common/app_cubit.dart';

/// User profile page widget
class ProfilePage extends StatelessWidget {
  /// Constructor
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous.user != current.user,
        builder: (context, state) {
          return state.user.identity.isAnonymous || state.user.profile == null
              ? LoadingIndicator(indicatorType: Indicator.orbit)
              : Center(
                  child: Column(
                    children: [
                      SelectableText(
                        state.user.profile?.name ?? 'no name',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(height: 45.0),
                      SelectableText('Email and Unique ID',
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 15.0),
                      SelectableText(state.user.identity.email.toString(),
                          style: Theme.of(context).textTheme.headline6),
                      SelectableText('ID: ${state.user.identity.id}',
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
