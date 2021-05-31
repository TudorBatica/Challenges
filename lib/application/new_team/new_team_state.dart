part of 'new_team_cubit.dart';

/// Models the state of the form which creates a new team
@immutable
class NewTeamState extends Equatable {
  /// Team name input
  late final TeamNameInput nameInput;

  /// Team members(other than the currently logged in user)
  late final MembersInput members;

  /// current form status
  final FormzStatus status;

  /// Constructor
  NewTeamState({
    required this.nameInput,
    required this.members,
    required this.status,
  });

  /// Initial state
  NewTeamState.intial({this.status = FormzStatus.pure}) {
    nameInput = TeamNameInput.pure();
    members = MembersInput.pure();
  }

  @override
  List<Object?> get props => [nameInput, members, status];

  /// Copy constructor
  NewTeamState copyWith({
    TeamNameInput? nameInput,
    MembersInput? members,
    FormzStatus? status,
  }) {
    return NewTeamState(
      nameInput: nameInput ?? this.nameInput,
      members: members ?? this.members,
      status: status ?? this.status,
    );
  }
}
