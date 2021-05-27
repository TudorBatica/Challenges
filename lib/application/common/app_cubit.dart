import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/authentication/authentication_repository.dart';
import '../../domain/authentication/user_identity.dart';
import '../../domain/common/user.dart';
import '../navigation/navigation_service.dart';

part 'app_state.dart';

/// Cubit which manages the part of the app's state
/// which may be considered 'global' (e.g.: the currently logged in user).
/// Also manages navigation requests from widgets which do not have another
/// cubit associated.
@injectable
class AppCubit extends Cubit<AppState> {
  /// Constructor
  AppCubit(this._authenticationRepository, this._navigationService)
      : super(AppState(user: User(identity: UserIdentity.anonymous))) {
    _userSubscription = _authenticationRepository.user
        .listen((user) => emit(state.copyWith(user: user)));
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  final NavigationService _navigationService;

  /// Push a new route.
  Future<void> navigateTo(String routeName) async {
    await _navigationService.navigateToo(routeName, state.user);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
