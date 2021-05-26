import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/new_challenge/new_challenge_cubit.dart';
import '../common/base_form.dart';
import 'date_time_input_fields.dart';
import 'general_information_input_fields.dart';
import 'submit_button.dart';
import 'task_input_field.dart';
import 'team_and_prize_input_fields.dart';

/// Form for adding a new challenge
class NewChallengeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NewChallengeCubit, NewChallengeState>(
      listener: (context, state) {},
      child: Align(
        child: BaseForm(
          elements: [
            Text(
              'Create a new challenge',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 45.0),
            Text(
              'General information',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 25.0),
            TitleInput(),
            SizedBox(height: 25.0),
            DescriptionInput(),
            SizedBox(height: 25.0),
            CategoryInput(),
            SizedBox(height: 45.0),
            Text(
              'Schedule',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 25.0),
            RegistrationDeadlineField(),
            SizedBox(height: 25.0),
            StartingDatetimeField(),
            SizedBox(height: 25.0),
            SolutionSubmissionDeadlineField(),
            SizedBox(height: 45.0),
            Text(
              'Prize',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 25.0),
            PrizeInput(),
            SizedBox(height: 45.0),
            Text(
              'Team size',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 45.0),
            TeamSizeInput(),
            SizedBox(height: 45.0),
            Text(
              'Task',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 25.0),
            TaskInput(),
            SizedBox(height: 65.0),
            SubmitButtonWrap()
          ],
        ),
      ),
    );
  }
}
