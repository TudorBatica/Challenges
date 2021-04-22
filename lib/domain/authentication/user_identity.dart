import 'package:equatable/equatable.dart';

/// {@template UserIdentity}
/// Represents a user's identity, but not their profile
/// (for profile see `UserProfile`).
///
/// Models a user's *unique properties*, such as their id and email address.
///
/// `UserIdentity.anonymous` represents an unauthenticated user.
/// {@endtemplate}
class UserIdentity extends Equatable {
  /// Constructor
  const UserIdentity({this.email, required this.id, this.isConfirmed = false});

  /// Unique id (it is not the display name).
  final String id;

  /// Registration email
  final String? email;

  /// User has a confirmed email address
  final bool isConfirmed;

  /// Represents the unauthenticated user.
  static const anonymous = UserIdentity(id: '');

  /// No user authenticated
  bool get isAnonymous => this == UserIdentity.anonymous;

  @override
  List<Object?> get props => [email, id, isConfirmed];
}
