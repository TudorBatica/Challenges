import 'package:challengesapp/application/authentication/sign_up_cubit.dart';
import 'package:challengesapp/application/authentication/confirmed_password.dart';
import 'package:challengesapp/application/authentication/email.dart';
import 'package:challengesapp/application/authentication/password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  const email = Email.dirty('email');
  const password = Password.dirty('password');
  const confirmedPassword = ConfirmedPassword.dirty(password: 'password');

  group('Sign up state behaviour', () {
    test('supports value comparison', () {
      final signInState = SignUpState(
          email: email,
          password: password,
          confirmedPassword: confirmedPassword);
      final valueIdenticalState = SignUpState(
          email: email,
          password: password,
          confirmedPassword: confirmedPassword);
      expect(signInState, valueIdenticalState);
    });

    test('returns object with changed email when email is passed', () {
      expect(SignUpState().copyWith(email: email), SignUpState(email: email));
    });

    test('returns object with changed password when password is passed', () {
      expect(SignUpState().copyWith(password: password),
          SignUpState(password: password));
    });

    test('''returns object with changed confirmed 
        password when confirmed password is passed''', () {
      expect(SignUpState().copyWith(confirmedPassword: confirmedPassword),
          SignUpState(confirmedPassword: confirmedPassword));
    });

    test('returns object with changed status when status is passed', () {
      expect(SignUpState().copyWith(status: FormzStatus.submissionSuccess),
          SignUpState(status: FormzStatus.submissionSuccess));
    });

    test('identical objects value-wise have identical hash codes', () {
      expect(SignUpState().hashCode, SignUpState().hashCode);
    });
  });
}
