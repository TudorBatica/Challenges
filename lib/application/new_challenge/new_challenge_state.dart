// ignore_for_file: public_member_api_docs
part of 'new_challenge_cubit.dart';

/// Host new challenge form state representation
@immutable
class NewChallengeState extends Equatable {
  late final TitleInput title;
  late final DescriptionInput description;
  late final CategoryInput category;

  late final RegistrationDeadlineInput registrationDeadline;
  late final StartingDatetimeInput startingDatetime;
  late final SolutionSubmissionDeadlineInput solutionSubmissionDeadline;

  late final PrizeInput prize;
  late final TeamSizeInput teamSize;

  late final TaskInput task;

  late final ImageSelectionInput image;

  /// current form status
  final FormzStatus status;

  NewChallengeState.intial({this.status = FormzStatus.pure}) {
    title = TitleInput.pure();
    description = DescriptionInput.pure();
    category = CategoryInput.pure();
    registrationDeadline = RegistrationDeadlineInput.pure();
    startingDatetime = StartingDatetimeInput.pure();
    solutionSubmissionDeadline = SolutionSubmissionDeadlineInput.pure();
    prize = PrizeInput.pure();
    teamSize = TeamSizeInput.pure(Pair(3, 10));
    task = TaskInput.pure();
    image = ImageSelectionInput.pure(Pair(null, null));
  }

  NewChallengeState({
    required this.title,
    required this.description,
    required this.category,
    required this.registrationDeadline,
    required this.startingDatetime,
    required this.solutionSubmissionDeadline,
    required this.prize,
    required this.teamSize,
    required this.task,
    required this.status,
    required this.image,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        registrationDeadline,
        startingDatetime,
        solutionSubmissionDeadline,
        prize,
        teamSize,
        task,
        image,
        status
      ];

  NewChallengeState copyWith({
    TitleInput? title,
    DescriptionInput? description,
    CategoryInput? category,
    RegistrationDeadlineInput? registrationDeadline,
    StartingDatetimeInput? startingDatetime,
    SolutionSubmissionDeadlineInput? solutionSubmissionDeadline,
    PrizeInput? prize,
    TeamSizeInput? teamSize,
    TaskInput? task,
    ImageSelectionInput? image,
    FormzStatus? status,
  }) =>
      NewChallengeState(
          title: title ?? this.title,
          description: description ?? this.description,
          category: category ?? this.category,
          registrationDeadline:
              registrationDeadline ?? this.registrationDeadline,
          startingDatetime: startingDatetime ?? this.startingDatetime,
          solutionSubmissionDeadline:
              solutionSubmissionDeadline ?? this.solutionSubmissionDeadline,
          prize: prize ?? this.prize,
          teamSize: teamSize ?? this.teamSize,
          task: task ?? this.task,
          status: status ?? this.status,
          image: image ?? this.image);
}
