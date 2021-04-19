import 'package:bloc_test/bloc_test.dart';
import 'package:challengesapp/application/authentication/sign_in_cubit.dart';
import 'package:challengesapp/domain/authentication/email.dart';
import 'package:challengesapp/domain/authentication/password.dart';
import 'package:challengesapp/infrastructure/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 'Abcd#efg1';
  const validPassword = Password.dirty(validPasswordString);

  group('sign in cubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthRepository();
      when(
        () => authenticationRepository.signInWithEmailAndPassword(
            email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer((_) async => null);
    });

    test('initial state is SignInState', () {
      expect(SignInCubit(authenticationRepository).state, SignInState());
    });

    group('email changed', () {
      blocTest<SignInCubit, SignInState>(
          'changes email and emits `invalid` when email/password are invalid',
          build: () => SignInCubit(authenticationRepository),
          act: (cubit) => cubit.emailChanged(invalidEmailString),
          expect: () => const [
                SignInState(email: invalidEmail, status: FormzStatus.invalid)
              ]);
      blocTest<SignInCubit, SignInState>(
          'changes email and emits `valid` when email/password are valid',
          build: () => SignInCubit(authenticationRepository),
          seed: () => SignInState(password: validPassword),
          act: (cubit) => cubit.emailChanged(validEmailString),
          expect: () => const [
                SignInState(
                    email: validEmail,
                    password: validPassword,
                    status: FormzStatus.valid)
              ]);
    });

    group('password changed', () {
      blocTest<SignInCubit, SignInState>(
          'changes password and emits `invalid` when email/password are invalid',
          build: () => SignInCubit(authenticationRepository),
          act: (cubit) => cubit.passwordChanged(invalidPasswordString),
          expect: () => const [
                SignInState(
                    password: invalidPassword, status: FormzStatus.invalid)
              ]);
      blocTest<SignInCubit, SignInState>(
          'changes password and emits `valid` when email/password are valid',
          build: () => SignInCubit(authenticationRepository),
          seed: () => SignInState(email: validEmail),
          act: (cubit) => cubit.passwordChanged(validPasswordString),
          expect: () => const [
                SignInState(
                    email: validEmail,
                    password: validPassword,
                    status: FormzStatus.valid)
              ]);
    });

    group('sign in with email and password', () {
      blocTest<SignInCubit, SignInState>(
          'does nothing when status is not validated',
          build: () => SignInCubit(authenticationRepository),
          act: (cubit) => cubit.signInWithEmailAndPassword(),
          expect: () => const []);

      blocTest<SignInCubit, SignInState>(
          'emits submissionInProgress and then submissionSuccess ' +
              'when signInWithEmailAndPassword is successful',
          build: () => SignInCubit(authenticationRepository),
          seed: () => SignInState(
                status: FormzStatus.valid,
                email: validEmail,
                password: validPassword,
              ),
          act: (cubit) => cubit.signInWithEmailAndPassword(),
          expect: () => const [
                SignInState(
                    status: FormzStatus.submissionInProgress,
                    email: validEmail,
                    password: validPassword),
                SignInState(
                    status: FormzStatus.submissionSuccess,
                    email: validEmail,
                    password: validPassword)
              ]);

      blocTest<SignInCubit, SignInState>(
        'emits [submissionInProgress, submissionFailure] '
        'when signInWithEmailAndPassword fails',
        build: () {
          when(
            () => authenticationRepository.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('sign in failed'));
          return SignInCubit(authenticationRepository);
        },
        seed: () => SignInState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
        ),
        act: (cubit) => cubit.signInWithEmailAndPassword(),
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.submissionInProgress,
            email: validEmail,
            password: validPassword,
          ),
          SignInState(
            status: FormzStatus.submissionFailure,
            email: validEmail,
            password: validPassword,
          )
        ],
      );
    });
  });
}
