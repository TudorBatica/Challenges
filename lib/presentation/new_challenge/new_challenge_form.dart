import 'package:challengesapp/presentation/common/button_with_border.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../application/common/app_cubit.dart';
import '../../application/new_challenge/new_challenge_cubit.dart';
import '../../domain/common/pair.dart';

final _dateTimeErrorMessage =
    '''Challenge schedule must respect the following chronological order:
Registration -> Start -> Solution Submission''';

/// Form for adding a new challenge
class NewChallengeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NewChallengeCubit, NewChallengeState>(
      listener: (context, state) {},
      child: Align(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 900,
            maxHeight: MediaQuery.of(context).size.height * 0.80,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
          ),
          child: Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    _TitleInput(),
                    SizedBox(height: 25.0),
                    _DescriptionInput(),
                    SizedBox(height: 25.0),
                    _CategoryInput(),
                    SizedBox(height: 45.0),
                    Text(
                      'Schedule',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 25.0),
                    _RegistrationDeadlineField(),
                    SizedBox(height: 25.0),
                    _StartingDatetimeField(),
                    SizedBox(height: 25.0),
                    _SolutionSubmissionDeadlineField(),
                    SizedBox(height: 45.0),
                    Text(
                      'Prize',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 25.0),
                    _PrizeInput(),
                    SizedBox(height: 45.0),
                    Text(
                      'Team size',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 45.0),
                    _TeamSizeInput(),
                    SizedBox(height: 45.0),
                    Text(
                      'Task',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 25.0),
                    _TaskInput(),
                    SizedBox(height: 65.0),
                    _SubmitButtonWrap()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_titleInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().titleChanged(value),
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.title.invalid
                ? 'Give your challenge a memorable name'
                    ' (of at least 5 characters)'
                : null,
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

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_descriptionInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().descriptionChanged(value),
          decoration: InputDecoration(
            labelText: 'Description (NOT the actual task)',
            errorText: state.description.invalid
                ? 'Enter a description of at least 10 characters '
                    'that offers some context about your challenge'
                : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          maxLines: null,
        );
      },
    );
  }
}

class _CategoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_categoryInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().categoryChanged(value),
          decoration: InputDecoration(
            labelText: 'Category',
            errorText: state.category.invalid ? 'Invalid category' : null,
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

class _RegistrationDeadlineField extends _DateTimeField {
  _RegistrationDeadlineField()
      : super(
          labelText: 'Registration deadline',
          errorTextFunction: (state) =>
              state.registrationDeadline.invalid ? _dateTimeErrorMessage : null,
          onDateTimeSelected: (context, selectedDateTime) => context
              .read<NewChallengeCubit>()
              .registrationDeadlineChanged(selectedDateTime),
          buildWhen: (previous, current) =>
              previous.solutionSubmissionDeadline !=
                  current.solutionSubmissionDeadline ||
              previous.startingDatetime != current.startingDatetime ||
              previous.registrationDeadline != current.registrationDeadline,
        );
}

class _StartingDatetimeField extends _DateTimeField {
  _StartingDatetimeField()
      : super(
          labelText: 'Starting datetime',
          errorTextFunction: (state) => state.startingDatetime.invalid
              ? 'The challenge has to start before the solution submission '
                  'deadline and after the registration deadline.'
              : null,
          onDateTimeSelected: (context, selectedDateTime) {
            context
                .read<NewChallengeCubit>()
                .startingDateTimeChanged(selectedDateTime);
          },
          buildWhen: (previous, current) =>
              previous.solutionSubmissionDeadline !=
                  current.solutionSubmissionDeadline ||
              previous.startingDatetime != current.startingDatetime ||
              previous.registrationDeadline != current.registrationDeadline,
        );
}

class _SolutionSubmissionDeadlineField extends _DateTimeField {
  _SolutionSubmissionDeadlineField()
      : super(
          labelText: 'Solution submission',
          errorTextFunction: (state) => state.solutionSubmissionDeadline.invalid
              ? _dateTimeErrorMessage
              : null,
          onDateTimeSelected: (context, selectedDateTime) => context
              .read<NewChallengeCubit>()
              .solutionSubmissionDeadlineChanged(selectedDateTime),
          buildWhen: (previous, current) =>
              previous.solutionSubmissionDeadline !=
                  current.solutionSubmissionDeadline ||
              previous.startingDatetime != current.startingDatetime ||
              previous.registrationDeadline != current.registrationDeadline,
        );
}

class _PrizeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.prize != current.prize,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_prizeInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().prizeChanged(value),
          decoration: InputDecoration(
            labelText: 'Prize',
            errorText: state.prize.invalid ? 'Describe your prize' : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          maxLines: null,
        );
      },
    );
  }
}

class _TeamSizeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.teamSize != current.teamSize,
      builder: (context, state) => RangeSlider(
        values: RangeValues(state.teamSize.value.first.toDouble(),
            state.teamSize.value.second.toDouble()),
        max: 15,
        min: 2,
        divisions: 13,
        labels: RangeLabels(state.teamSize.value.first.toString(),
            state.teamSize.value.second.toString()),
        onChanged: (value) => context
            .read<NewChallengeCubit>()
            .teamSizeChanged(Pair(value.start.toInt(), value.end.toInt())),
      ),
    );
  }
}

class _TaskInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) => previous.task != current.task,
      builder: (context, state) {
        return TextField(
          key: const Key('newChallengeForm_taskInput_textField'),
          onChanged: (value) =>
              context.read<NewChallengeCubit>().taskChanged(value),
          decoration: InputDecoration(
            labelText: 'Task',
            errorText: state.task.invalid ? 'invalid task' : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          maxLines: null,
        );
      },
    );
  }
}

class _SubmitButtonWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : _SubmitButton(
                  onPressed: state.status.isValidated
                      ? context.read<NewChallengeCubit>().submitForm
                      : null);
        });
  }
}

class _SubmitButton extends StatelessWidget {
  final Future<void> Function(String, String)? onPressed;

  const _SubmitButton({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) => (onPressed == null)
          ? ButtonWithBorder(text: 'CREATE CHALLENGE')
          : ButtonWithBorder(
              text: 'CREATE CHALLENGE',
              onPressed: () =>
                  onPressed!(state.user.identity.id, state.user.profile!.name),
            ),
    );
  }
}

class _DateTimeField extends StatelessWidget {
  final void Function(BuildContext, DateTime) onDateTimeSelected;
  final bool Function(NewChallengeState, NewChallengeState) buildWhen;
  final String labelText;
  final String? Function(NewChallengeState) errorTextFunction;

  const _DateTimeField(
      {Key? key,
      required this.onDateTimeSelected,
      required this.labelText,
      required this.errorTextFunction,
      required this.buildWhen})
      : super(key: key);

  _getDateFromUser(BuildContext context, DateTime? current) async {
    final date = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    return date;
  }

  _getTimeFromUser(BuildContext context, DateTime? current) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        current ?? DateTime.now(),
      ),
    );
    return time;
  }

  _onShowPicker(BuildContext context, DateTime? current) async {
    final date = await _getDateFromUser(context, current);
    if (date == null) {
      return current;
    }
    final time = await _getTimeFromUser(context, current);
    if (time == null) {
      return current;
    }
    final selectedDateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    onDateTimeSelected(context, selectedDateTime);
    return DateTimeField.combine(date, time);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: buildWhen,
      builder: (context, state) {
        return DateTimeField(
          decoration: InputDecoration(
              labelText: labelText, errorText: errorTextFunction(state)),
          format: DateFormat('dd-MM-yyyy HH:mm'),
          onShowPicker: (context, current) async =>
              await _onShowPicker(context, current),
        );
      },
    );
  }
}
