part of 'new_team_cubit.dart';

/// Models the state of the form which creates a new team
@immutable
class NewTeamState extends Equatable {
  /// Team name input
  late final TeamNameInput nameInput;

  /// Team members(other than the currently logged in user)
  late final MembersInput members;

  /// User to invite
  final String userId;

  /// User with given id not found
  final bool userNotFound;

  /// current form status
  final FormzStatus status;

  /// Constructor
  NewTeamState(
      {required this.nameInput,
      required this.members,
      required this.status,
      required this.userNotFound,
      required this.userId});

  /// Initial state
  NewTeamState.intial(
      {this.status = FormzStatus.pure,
      this.userNotFound = false,
      this.userId = ''}) {
    nameInput = TeamNameInput.pure();
    members = MembersInput.pure();
  }

  @override
  List<Object?> get props => [nameInput, members, userNotFound, userId, status];

  /// Copy constructor
  NewTeamState copyWith(
      {TeamNameInput? nameInput,
      MembersInput? members,
      FormzStatus? status,
      bool? userNotFound,
      String? userId}) {
    return NewTeamState(
        nameInput: nameInput ?? this.nameInput,
        members: members ?? this.members,
        status: status ?? this.status,
        userNotFound: userNotFound ?? this.userNotFound,
        userId: userId ?? this.userId);
  }
}
