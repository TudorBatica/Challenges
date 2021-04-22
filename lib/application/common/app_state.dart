part of 'app_cubit.dart';

/// Representation of the part of the app's state which may be considered global
/// (e.g.): the currently logged in user.
@immutable
class AppState extends Equatable {
  /// The currently logged in user.
  final UserIdentity user;

  /// Constructor
  const AppState({this.user = UserIdentity.anonymous});

  @override
  List<Object?> get props => [user];

  /// Copy factory
  AppState copyWith({
    UserIdentity? user,
  }) {
    return AppState(
      user: user ?? this.user,
    );
  }
}
