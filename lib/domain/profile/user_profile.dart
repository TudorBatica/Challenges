import 'package:equatable/equatable.dart';

/// {@template UserProfile}
/// Represents a user profile, but not their identity
/// (for identity see `UserIdentity`).
///
/// Models data which is related to the user's activity in the app.
/// {@endtemplate}
class UserProfile extends Equatable {
  /// Display name (not their unique id).
  final String name;

  // ignore: public_member_api_docs
  final String? profilePictureURL;

  // ignore: public_member_api_docs
  UserProfile({required this.name, this.profilePictureURL});

  @override
  List<Object?> get props => [name];
}
