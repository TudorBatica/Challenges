import 'package:challengesapp/domain/authentication/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const id = 'userid';
  const email = 'useremail@gmail.com';
  const name = 'John Doe';
  const profilePicture = 'https://www.demo.io/pic';

  group('Domain User', () {
    test('supports value equality', () {
      final someUser = User(
          id: id, email: email, name: name, profilePicture: profilePicture);
      final sameUser = User(
          id: id, email: email, name: name, profilePicture: profilePicture);
      expect(someUser, sameUser);
    });

    test('recognizes anonymous user (unauthenticated)', () {
      final anonUser = User(id: '');
      expect(anonUser.isAnonymous, true);
    });
  });
}
