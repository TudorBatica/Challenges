import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../application/new_challenge/new_challenge_cubit.dart';

final _dateTimeErrorMessage =
    '''Challenge schedule must respect the following chronological order:
Registration -> Start -> Solution Submission''';

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

class RegistrationDeadlineField extends _DateTimeField {
  RegistrationDeadlineField()
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

class StartingDatetimeField extends _DateTimeField {
  StartingDatetimeField()
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

class SolutionSubmissionDeadlineField extends _DateTimeField {
  SolutionSubmissionDeadlineField()
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
