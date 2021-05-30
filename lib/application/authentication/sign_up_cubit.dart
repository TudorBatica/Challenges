import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/authentication/authentication_repository.dart';

import 'confirmed_password.dart';
import 'email.dart';
import 'name.dart';
import 'password.dart';

part 'sign_up_state.dart';

/// Cubit which manages the sign up form state
@injectable
class SignUpCubit extends Cubit<SignUpState> {
  /// Constructor
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  /// Update state with new email
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        status: Formz.validate(
            [email, state.name, state.password, state.confirmedPassword])));
  }

  /// Update state with new name
  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
        name: name,
        status: Formz.validate(
            [state.email, name, state.password, state.confirmedPassword])));
  }

  /// Update state with new password
  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        name: state.name,
        password: password,
        confirmedPassword: state.confirmedPassword,
        status:
            Formz.validate([state.email, password, state.confirmedPassword])));
  }

  /// Update state with new confirmed password
  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      name: state.name,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  /// Handle sign up form submission
  Future<void> signUpWithEmailAndPassword() async {
    if (!state.status.isValidated) {
      return;
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
          name: state.name.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
