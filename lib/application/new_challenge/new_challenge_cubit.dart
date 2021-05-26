import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/challenge/challenge.dart';
import '../../domain/challenge/challenge_info.dart';
import '../../domain/challenge/challenge_repository.dart';
import '../../domain/challenge/challenge_task.dart';
import '../../domain/common/pair.dart';
import 'category_input.dart';
import 'description_input.dart';
import 'prize_input.dart';
import 'registration_deadline_input.dart';
import 'solution_submission_deadline_input.dart';
import 'starting_datetime_input.dart';
import 'task_input.dart';
import 'team_size_input.dart';
import 'title_input.dart';

part 'new_challenge_state.dart';

@injectable
class NewChallengeCubit extends Cubit<NewChallengeState> {
  final ChallengeRepository _challengeRepository;

  NewChallengeCubit(this._challengeRepository)
      : super(NewChallengeState.intial());

  void titleChanged(String value) {
    final title = TitleInput.dirty(value: value);
    emit(state.copyWith(
        title: title,
        status: Formz.validate([
          title,
          state.description,
          state.category,
          state.registrationDeadline,
          state.startingDatetime,
          state.solutionSubmissionDeadline,
          state.prize,
          state.teamSize,
          state.task
        ])));
  }

  void descriptionChanged(String value) {
    final description = DescriptionInput.dirty(value: value);
    emit(state.copyWith(
        description: description,
        status: Formz.validate([
          state.title,
          description,
          state.category,
          state.registrationDeadline,
          state.startingDatetime,
          state.solutionSubmissionDeadline,
          state.prize,
          state.teamSize,
          state.task
        ])));
  }

  void categoryChanged(String value) {
    final category = CategoryInput.dirty(value: value);
    emit(state.copyWith(
        category: category,
        status: Formz.validate([
          state.title,
          state.description,
          category,
          state.registrationDeadline,
          state.startingDatetime,
          state.solutionSubmissionDeadline,
          state.prize,
          state.teamSize,
          state.task
        ])));
  }

  void registrationDeadlineChanged(DateTime value,
      {bool isSideEffect = false}) {
    final registrationDeadline = RegistrationDeadlineInput.dirty(
        startingDatetime: state.startingDatetime.value,
        solutionSubmissionDateTime: state.solutionSubmissionDeadline.value,
        value: value);

    final startingDatetime = StartingDatetimeInput.dirty(
        registrationDeadline: value,
        solutionSubmissionDateTime: state.solutionSubmissionDeadline.value,
        value: state.startingDatetime.value);

    final solutionSubmissionDeadline = SolutionSubmissionDeadlineInput.dirty(
        registrationDeadline: value,
        startingDatetime: state.startingDatetime.value,
        value: state.solutionSubmissionDeadline.value);

    emit(state.copyWith(
        registrationDeadline: registrationDeadline,
        status: Formz.validate([
          state.title,
          state.description,
          state.category,
          registrationDeadline,
          startingDatetime,
          solutionSubmissionDeadline,
          state.prize,
          state.teamSize,
          state.task
        ])));
  }

  void startingDateTimeChanged(DateTime value, {bool isSideEffect = false}) {
    final startingDatetime = StartingDatetimeInput.dirty(
        registrationDeadline: state.registrationDeadline.value,
        solutionSubmissionDateTime: state.solutionSubmissionDeadline.value,
        value: value);

    final solutionSubmissionDeadline = SolutionSubmissionDeadlineInput.dirty(
        registrationDeadline: state.registrationDeadline.value,
        startingDatetime: value,
        value: state.solutionSubmissionDeadline.value);

    final registrationDeadline = RegistrationDeadlineInput.dirty(
        startingDatetime: value,
        solutionSubmissionDateTime: state.solutionSubmissionDeadline.value,
        value: state.registrationDeadline.value);

    emit(state.copyWith(
        startingDatetime: startingDatetime,
        status: Formz.validate([
          state.title,
          state.description,
          state.category,
          registrationDeadline,
          startingDatetime,
          solutionSubmissionDeadline,
          state.prize,
          state.teamSize,
          state.task
        ])));
  }

  void solutionSubmissionDeadlineChanged(DateTime value,
      {bool isSideEffect = false}) {
    final solutionSubmissionDeadline = SolutionSubmissionDeadlineInput.dirty(
        registrationDeadline: state.registrationDeadline.value,
        startingDatetime: state.startingDatetime.value,
        value: value);

    final registrationDeadline = RegistrationDeadlineInput.dirty(
        startingDatetime: state.startingDatetime.value,
        solutionSubmissionDateTime: value,
        value: state.registrationDeadline.value);

    final startingDatetime = StartingDatetimeInput.dirty(
        registrationDeadline: state.registrationDeadline.value,
        solutionSubmissionDateTime: value,
        value: state.startingDatetime.value);

    emit(state.copyWith(
        solutionSubmissionDeadline: solutionSubmissionDeadline,
        status: Formz.validate([
          state.title,
          state.description,
          state.category,
          registrationDeadline,
          startingDatetime,
          solutionSubmissionDeadline,
          state.prize,
          state.teamSize,
          state.task
        ])));
  }

  void prizeChanged(String value) {
    final prize = PrizeInput.dirty(value: value);
    emit(state.copyWith(
        prize: prize,
        status: Formz.validate([
          state.title,
          state.description,
          state.category,
          state.registrationDeadline,
          state.startingDatetime,
          state.solutionSubmissionDeadline,
          prize,
          state.teamSize,
          state.task
        ])));
  }

  void teamSizeChanged(Pair<int, int> value) {
    final teamSize = TeamSizeInput.dirty(value);
    emit(state.copyWith(
        teamSize: teamSize,
        status: Formz.validate([
          state.title,
          state.description,
          state.category,
          state.registrationDeadline,
          state.startingDatetime,
          state.solutionSubmissionDeadline,
          state.prize,
          teamSize,
          state.task
        ])));
  }

  void taskChanged(String value) {
    final task = TaskInput.dirty(value: value);
    emit(state.copyWith(
        task: task,
        status: Formz.validate([
          state.title,
          state.description,
          state.category,
          state.registrationDeadline,
          state.startingDatetime,
          state.solutionSubmissionDeadline,
          state.prize,
          state.teamSize,
          task
        ])));
  }

  Future<void> submitForm() async {
    if (!state.status.isValidated) {
      return;
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _challengeRepository.createNewChallenge(_stateToChallenge());
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  ChallengeInfo _stateToChallengeInfo() => ChallengeInfo(
        title: state.title.value,
        description: state.description.value,
        category: state.category.value,
        registration: state.registrationDeadline.value,
        start: state.startingDatetime.value,
        submission: state.solutionSubmissionDeadline.value,
        prize: state.prize.value,
        teamSizeMin: state.teamSize.value.first,
        teamSizeMax: state.teamSize.value.second,
      );

  ChallengeTask _stateToChallengeTask() =>
      ChallengeTask(title: '', description: state.description.value);

  Challenge _stateToChallenge() => Challenge(
      information: _stateToChallengeInfo(), task: _stateToChallengeTask());
}
