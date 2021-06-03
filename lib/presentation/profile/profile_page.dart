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
              : BaseForm(
                  elements: [
                    Icon(
                      Icons.person,
                      size: 150.0,
                    ),
                    SizedBox(height: 15.0),
                    SelectableText(
                      state.user.profile!.name,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(height: 15.0),
                    ButtonWithBorder(
                      text: 'LOG OUT',
                      borderColor: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () async {
                        await context.read<AppCubit>().logUserOut();
                        context
                            .read<AppCubit>()
                            .navigateTo(challengesListRoute);
                      },
                    ),
                    SizedBox(height: 30.0),
                    SelectableText('Email and Unique ID',
                        style: Theme.of(context).textTheme.headline5),
                    SizedBox(height: 15.0),
                    SelectableText(state.user.identity.email.toString(),
                        style: Theme.of(context).textTheme.headline6),
                    SelectableText('ID: ${state.user.identity.id}',
                        style: Theme.of(context).textTheme.headline6),
                  ],
                );
        },
      ),
    );
  }
}
