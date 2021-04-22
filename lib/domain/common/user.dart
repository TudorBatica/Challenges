import 'package:equatable/equatable.dart';

import '../authentication/user_identity.dart';
import '../profile/user_profile.dart';

/// Represents a complete blueprint of a user,
/// holding both their identity and their profile.
class User extends Equatable {
  /// {@macro UserIdentity}
  final UserIdentity identity;

  /// {@macro UserProfile}
  final UserProfile profile;

  // ignore: public_member_api_docs
  User({required this.identity, required this.profile});

  @override
  List<Object?> get props => [identity, profile];
}
