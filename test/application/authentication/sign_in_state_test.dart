import 'package:challengesapp/application/authentication/sign_in_cubit.dart';
import 'package:challengesapp/domain/authentication/email.dart';
import 'package:challengesapp/domain/authentication/password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  const email = Email.dirty('email');
  const password = Password.dirty('password');

  group('Sign in state behaviour', () {
    test('supports value comparison', () {
      final signInState = SignInState(email: email, password: password);
      final valueIdenticalState = SignInState(email: email, password: password);
      expect(signInState, valueIdenticalState);
    });

    test('returns same object when copyWith is called with no properties', () {
      expect(SignInState(), SignInState().copyWith());
    });

    test('returns object with changed email when email is passed', () {
      expect(SignInState().copyWith(email: email), SignInState(email: email));
    });

    test('returns object with changed password when password is passed', () {
      expect(SignInState().copyWith(password: password),
          SignInState(password: password));
    });

    test('returns object with changed status when status is passed', () {
      expect(SignInState().copyWith(status: FormzStatus.submissionSuccess),
          SignInState(status: FormzStatus.submissionSuccess));
    });

    test('identical objects value-wise have identical hash codes', () {
      expect(SignInState().hashCode, SignInState().hashCode);
    });
  });
}
