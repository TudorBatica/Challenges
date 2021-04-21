import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/authentication/authentication_repository.dart';
import '../../domain/authentication/user.dart';

part 'app_state.dart';

/// Cubit which manages the part of the app's state
/// which may be considered 'global' (e.g.: the current logged in user).
@injectable
class AppCubit extends Cubit<AppState> {
  /// Constructor
  AppCubit(this._authenticationRepository) : super(const AppState()) {
    _userSubscription = _authenticationRepository.user
        .listen((user) => emit(state.copyWith(user: user)));
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
