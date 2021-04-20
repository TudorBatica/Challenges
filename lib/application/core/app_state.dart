part of 'app_cubit.dart';

@immutable
class AppState extends Equatable {
  final User user;

  const AppState({this.user = User.anonymous});

  @override
  List<Object?> get props => [user];

  AppState copyWith({
    User? user,
  }) {
    return AppState(
      user: user ?? this.user,
    );
  }
}
