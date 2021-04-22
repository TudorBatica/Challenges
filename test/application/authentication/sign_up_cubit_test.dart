import 'package:bloc_test/bloc_test.dart';
import 'package:challengesapp/application/authentication/sign_up_cubit.dart';
import 'package:challengesapp/application/authentication/confirmed_password.dart';
import 'package:challengesapp/application/authentication/email.dart';
import 'package:challengesapp/application/authentication/password.dart';
import 'package:challengesapp/domain/authentication/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 'abcdef1!';
  const validPassword = Password.dirty(validPasswordString);

  const invalidConfirmedPasswordString = 'invalid';
  const invalidConfirmedPassword = ConfirmedPassword.dirty(
    password: validPasswordString,
    value: invalidConfirmedPasswordString,
  );

  const validConfirmedPasswordString = 'abcdef1!';
  const validConfirmedPassword = ConfirmedPassword.dirty(
    password: validPasswordString,
    value: validConfirmedPasswordString,
  );

  group('SignUpCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      when(
        () => authenticationRepository.signUpWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => null);
    });

    test('initial state is SignUpState', () {
      expect(SignUpCubit(authenticationRepository).state, SignUpState());
    });

    group('emailChanged', () {
      blocTest<SignUpCubit, SignUpState>(
        'emits [invalid] when email/password/confirmedPassword are invalid',
        build: () => SignUpCubit(authenticationRepository),
        act: (cubit) => cubit.emailChanged(invalidEmailString),
        expect: () => const [
          SignUpState(email: invalidEmail, status: FormzStatus.invalid),
        ],
      );

      blocTest<SignUpCubit, SignUpState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => SignUpCubit(authenticationRepository),
        seed: () => SignUpState(
          email: validEmail,
          password: validPassword,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.emailChanged(validEmailString),
        expect: () => const [
          SignUpState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('passwordChanged', () {
      blocTest<SignUpCubit, SignUpState>(
        'emits [invalid] when email/password/confirmedPassword are invalid',
        build: () => SignUpCubit(authenticationRepository),
        act: (cubit) => cubit.passwordChanged(invalidPasswordString),
        expect: () => const [
          SignUpState(
            password: invalidPassword,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<SignUpCubit, SignUpState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => SignUpCubit(authenticationRepository),
        seed: () => SignUpState(
          email: validEmail,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.passwordChanged(validPasswordString),
        expect: () => const <SignUpState>[
          SignUpState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('confirmedPasswordChanged', () {
      blocTest<SignUpCubit, SignUpState>(
        'emits [invalid] when email/password/confirmedPassword are invalid',
        build: () => SignUpCubit(authenticationRepository),
        act: (cubit) =>
            cubit.confirmedPasswordChanged(invalidConfirmedPasswordString),
        expect: () => const <SignUpState>[
          SignUpState(
            confirmedPassword: invalidConfirmedPassword,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<SignUpCubit, SignUpState>(
        'emits [valid] when email/password/confirmedPassword are valid',
        build: () => SignUpCubit(authenticationRepository),
        seed: () => SignUpState(email: validEmail, password: validPassword),
        act: (cubit) => cubit.confirmedPasswordChanged(
          validConfirmedPasswordString,
        ),
        expect: () => const <SignUpState>[
          SignUpState(
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('Sign up with email and password', () {
      blocTest<SignUpCubit, SignUpState>(
        'does nothing when status is not validated',
        build: () => SignUpCubit(authenticationRepository),
        act: (cubit) => cubit.signUpWithEmailAndPassword(),
        expect: () => const <SignUpState>[],
      );

      blocTest<SignUpCubit, SignUpState>(
        'calls signUp with correct email/password/confirmedPassword',
        build: () => SignUpCubit(authenticationRepository),
        seed: () => SignUpState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.signUpWithEmailAndPassword(),
        verify: (_) {
          verify(
            () => authenticationRepository.signUpWithEmailAndPassword(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<SignUpCubit, SignUpState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when signUp succeeds',
        build: () => SignUpCubit(authenticationRepository),
        seed: () => SignUpState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.signUpWithEmailAndPassword(),
        expect: () => const <SignUpState>[
          SignUpState(
            status: FormzStatus.submissionInProgress,
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
          ),
          SignUpState(
            status: FormzStatus.submissionSuccess,
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
          )
        ],
      );

      blocTest<SignUpCubit, SignUpState>(
        'emits [submissionInProgress, submissionFailure] '
        'when signUp fails',
        build: () {
          when(
            () => authenticationRepository.signUpWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('Sign up failed!'));
          return SignUpCubit(authenticationRepository);
        },
        seed: () => SignUpState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
          confirmedPassword: validConfirmedPassword,
        ),
        act: (cubit) => cubit.signUpWithEmailAndPassword(),
        expect: () => const [
          SignUpState(
            status: FormzStatus.submissionInProgress,
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
          ),
          SignUpState(
            status: FormzStatus.submissionFailure,
            email: validEmail,
            password: validPassword,
            confirmedPassword: validConfirmedPassword,
          )
        ],
      );
    });
  });
}
