import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/authentication/authentication_repository.dart';
import '../../domain/authentication/user_identity.dart';
import '../../domain/common/user.dart';
import '../navigation/logged_in_users_only_routes.dart';
import '../navigation/route_names.dart';

part 'app_state.dart';

/// Cubit which manages the part of the app's state
/// which may be considered 'global' (e.g.: the currently logged in user).
/// Also manages navigation requests from widgets.
class AppCubit extends Cubit<AppState> {
  /// Constructor
  AppCubit(this._authenticationRepository, this.navigatorKey)
      : super(AppState(user: User(identity: UserIdentity.anonymous))) {
    _userSubscription = _authenticationRepository.user
        .listen((user) => emit(state.copyWith(user: user)));
  }

  /// Global key for navigation
  final GlobalKey<NavigatorState> navigatorKey;

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  /// Push a new route
  Future<dynamic>? navigateTo(String routeName) {
    if (state.user.identity.isAnonymous &&
        loggedInUsersOnlyRoutes.contains(routeName)) {
      return navigatorKey.currentState?.pushNamed(signUpRoute);
    }
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  /// Pop current route
  void navigateBack() {
    return navigatorKey.currentState?.pop();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
