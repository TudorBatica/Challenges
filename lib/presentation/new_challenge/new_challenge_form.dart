import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import '../../application/new_challenge/new_challenge_cubit.dart';
import '../common/base_form.dart';
import 'date_time_input_fields.dart';
import 'general_information_input_fields.dart';
import 'image_selection_input_field.dart';
import 'submit_button.dart';
import 'task_input_field.dart';
import 'team_and_prize_input_fields.dart';

/// Form for adding a new challenge
class NewChallengeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NewChallengeCubit, NewChallengeState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(
                    'We could not upload your challenge. Please, try again.')));
        }
        if (state.status.isSubmissionSuccess) {
          BlocProvider.of<AppCubit>(context).navigateTo(profileRoute);
        }
      },
      child: Align(
        child: BaseForm(
          elements: [
            Text(
              'Create a new challenge',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 45.0),
            Row(
              children: [
                Icon(Icons.info_outline_rounded),
                SizedBox(width: 5.0),
                Text(
                  'General information',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 25.0),
            TitleInput(),
            SizedBox(height: 25.0),
            DescriptionInput(),
            SizedBox(height: 25.0),
            CategoryInput(),
            SizedBox(height: 45.0),
            Row(
              children: [
                Icon(Icons.calendar_today_rounded),
                SizedBox(width: 5.0),
                Text(
                  'Schedule',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 25.0),
            RegistrationDeadlineField(),
            SizedBox(height: 25.0),
            StartingDatetimeField(),
            SizedBox(height: 25.0),
            SolutionSubmissionDeadlineField(),
            SizedBox(height: 45.0),
            Row(
              children: [
                Icon(Icons.stars_rounded),
                SizedBox(width: 5.0),
                Text(
                  'Prize',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 25.0),
            PrizeInput(),
            SizedBox(height: 45.0),
            Row(
              children: [
                Icon(Icons.people_outline_rounded),
                SizedBox(width: 5.0),
                Text(
                  'Team size',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 45.0),
            TeamSizeInput(),
            SizedBox(height: 45.0),
            Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded),
                SizedBox(width: 5.0),
                Text(
                  'Task',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 25.0),
            TaskInput(),
            SizedBox(height: 45.0),
            Row(
              children: [
                Icon(Icons.image),
                SizedBox(width: 5.0),
                Text(
                  'Image',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 25.0),
            ImageSelectionInputField(),
            SizedBox(height: 65.0),
            SubmitButtonWrap()
          ],
        ),
      ),
    );
  }
}
