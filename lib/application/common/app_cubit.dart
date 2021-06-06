import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/authentication/authentication_repository.dart';
import '../../domain/authentication/user_identity.dart';
import '../../domain/common/user.dart';
import '../navigation/logged_in_users_only_routes.dart';
import '../navigation/route_names.dart';
import '../navigation/router.dart' as router;

part 'app_state.dart';

/// Cubit which manages the currently logged in user state
/// and navigation and asks permissions for push notifications
class AppCubit extends Cubit<AppState> {
  /// Constructor
  AppCubit(this._authenticationRepository, this.navigatorKey,
      this._firebaseMessaging)
      : super(AppState(user: User(identity: UserIdentity.anonymous))) {
    _userSubscription = _authenticationRepository.user
        .listen((user) => emit(state.copyWith(user: user)));
    askForPushNotificationsPermissions();
  }

  /// Global key for navigation
  final GlobalKey<NavigatorState> navigatorKey;

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  final FirebaseMessaging _firebaseMessaging;

  /// Route requested automatically by browser
  Route<dynamic> generateRoute(RouteSettings settings) {
    return router.generateRoute(settings);
  }

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

  /// Ask for permission for push notifications
  Future<void> askForPushNotificationsPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _createInitialHandshakeWithFirebaseMessaging();
    }
  }

  Future<void> _createInitialHandshakeWithFirebaseMessaging() async {
    final messagingToken = await _firebaseMessaging.getToken(
        vapidKey: 'BKS1ajSLsuJknuMLwO3wnarsA2nUxQnZZCi9ERkuhCW'
            'VZEcGZhdQobqbYHrSX7UFzQUPxoipSlTExsCGNE2HNT4');
    print(messagingToken);
  }

  ///TODO: move method
  Future<void> logUserOut() async {
    await _authenticationRepository.signOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
