import 'dart:async';

import 'package:challengesapp/domain/authentication/user.dart';
import 'package:challengesapp/infrastructure/authentication/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

@injectable
class AppCubit extends Cubit<AppState> {
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
