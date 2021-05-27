import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/challenge/challenge.dart';
import '../../domain/challenge/challenge_info.dart';
import '../../domain/challenge/challenge_repository.dart';
import '../../domain/challenge/challenge_storage_repository.dart';
import '../../domain/challenge/challenge_task.dart';
import '../../domain/common/pair.dart';
import '../navigation/navigation_service.dart';
import '../navigation/route_names.dart';
import 'category_input.dart';
import 'description_input.dart';
import 'image_selection_input.dart';
import 'prize_input.dart';
import 'registration_deadline_input.dart';
import 'solution_submission_deadline_input.dart';
import 'starting_datetime_input.dart';
import 'task_input.dart';
import 'team_size_input.dart';
import 'title_input.dart';

part 'new_challenge_state.dart';

/// Manages the state of the new challenge form
@injectable
class NewChallengeCubit extends Cubit<NewChallengeState> {
  final ChallengeRepository _challengeRepository;
  final ChallengeStorageRepository _challengeStorageRepository;
  final NavigationService _navigationService;

  /// Constructor with initial state
  NewChallengeCubit(this._challengeRepository, this._challengeStorageRepository,
      this._navigationService)
      : super(NewChallengeState.intial());

  /// Title input has been changed by user
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
          state.task,
          state.image
        ])));
  }

  /// Description input has been changed by user
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
          state.task,
          state.image
        ])));
  }

  /// Category input has been changed by user
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
          state.task,
          state.image
        ])));
  }

  /// Registration deadline input has been changed by user
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
          state.task,
          state.image
        ])));
  }

  /// Challenge starting datetime input has been changed by user
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
          state.task,
          state.image
        ])));
  }

  /// Solution submission deadline input has been changed by user
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
          state.task,
          state.image
        ])));
  }

  /// Prize input has been changed by user
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
          state.task,
          state.image
        ])));
  }

  /// Team size input has been changed by user
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
          state.task,
          state.image
        ])));
  }

  /// Task input has been changed by user
  void taskChanged(String value) {
    final task = TaskInput.dirty(value: value);
    emit(
      state.copyWith(
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
          task,
          state.image
        ]),
      ),
    );
  }

  /// Prompts the user to select a file
  Future<void> selectFile() async {
    final selectedFile = await FilePicker.platform
        .pickFiles(allowCompression: true, allowMultiple: false);
    if (selectedFile == null || selectedFile.files[0].bytes == null) {
      return;
    }

    final image = ImageSelectionInput.dirty(
        Pair(selectedFile.files[0].bytes, selectedFile.files[0].name));

    emit(state.copyWith(
        image: image,
        status: Formz.validate([
          state.title,
          state.description,
          state.category,
          state.registrationDeadline,
          state.startingDatetime,
          state.solutionSubmissionDeadline,
          state.prize,
          state.teamSize,
          state.task,
          image
        ])));
  }

  /// Submit the new challenge form
  Future<void> submitForm(String hostId, String hostName) async {
    if (!state.status.isValidated) {
      return;
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final imageURL =
          await _challengeStorageRepository.uploadImageAndRetrieveDownloadURL(
              _nullableUint8ListToNonNullable(state.image.value.first),
              state.image.value.second.toString());
      await _challengeRepository
          .createNewChallenge(_stateToChallenge(hostId, hostName, imageURL));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  /// Push the profile route
  Future<void> navigateToProfilePage() async {
    _navigationService.navigateTo(profileRoute);
  }

  // This horrible method is due to sound null safety
  Uint8List _nullableUint8ListToNonNullable(Uint8List? list) {
    if (list != null) {
      final newList = list;
      return newList;
    }
    throw Exception();
  }

  ChallengeInfo _stateToChallengeInfo(
          String hostId, String hostName, String imgURL) =>
      ChallengeInfo(
        challengeHostId: hostId,
        challengeHostName: hostName,
        title: state.title.value,
        description: state.description.value,
        category: state.category.value,
        registration: state.registrationDeadline.value,
        start: state.startingDatetime.value,
        submission: state.solutionSubmissionDeadline.value,
        prize: state.prize.value,
        teamSizeMin: state.teamSize.value.first,
        teamSizeMax: state.teamSize.value.second,
        imageURL: imgURL,
      );

  ChallengeTask _stateToChallengeTask() =>
      ChallengeTask(description: state.description.value);

  Challenge _stateToChallenge(String hostId, String hostName, String imgURL) =>
      Challenge(
          information: _stateToChallengeInfo(hostId, hostName, imgURL),
          task: _stateToChallengeTask());
}
