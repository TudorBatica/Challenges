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
    FormzStatus? status,
  }) {
    return NewChallengeState(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      registrationDeadline: registrationDeadline ?? this.registrationDeadline,
      startingDatetime: startingDatetime ?? this.startingDatetime,
      solutionSubmissionDeadline:
          solutionSubmissionDeadline ?? this.solutionSubmissionDeadline,
      prize: prize ?? this.prize,
      teamSize: teamSize ?? this.teamSize,
      task: task ?? this.task,
      status: status ?? this.status,
    );
  }
}
