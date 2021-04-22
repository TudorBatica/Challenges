import 'package:challengesapp/domain/authentication/user_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const id = 'userid';
  const email = 'useremail@gmail.com';

  group('Domain User', () {
    test('supports value equality', () {
      final someUser = UserIdentity(id: id, email: email);
      final sameUser = UserIdentity(id: id, email: email);
      expect(someUser, sameUser);
    });

    test('recognizes anonymous user (unauthenticated)', () {
      final anonUser = UserIdentity(id: '');
      expect(anonUser.isAnonymous, true);
    });
  });
}
