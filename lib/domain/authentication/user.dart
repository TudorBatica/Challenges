import 'package:equatable/equatable.dart';

/// User model class.
/// All other user model classes should be mapped to this one.
/// `User.anonymous` represents an unauthenticated user.
class User extends Equatable {
  /// Constructor
  const User({this.email, required this.id, this.name, this.profilePicture});

  /// User's email
  final String? email;

  /// User's id in the database (not the username - for username use `name`).
  final String id;

  /// User's display name
  final String? name;

  /// Profile picture URL.
  final String? profilePicture;

  /// Represents the unauthenticated user.
  static const anonymous = User(id: '');

  /// No user authenticated
  bool get isAnonymous => this == User.anonymous;

  @override
  List<Object?> get props => [email, id, name, profilePicture];
}
