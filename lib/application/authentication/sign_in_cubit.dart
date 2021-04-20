import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/authentication/email.dart';
import '../../domain/authentication/password.dart';
import '../../infrastructure/authentication/authentication_repository.dart';

part 'sign_in_state.dart';

/// Cubit which handles the sign in form state.
@injectable
class SignInCubit extends Cubit<SignInState> {
  final AuthenticationRepository _authenticationRepository;

  /// Constructor
  SignInCubit(this._authenticationRepository) : super(const SignInState());

  /// Update state with new email
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  /// Update state with new password
  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        password: password, status: Formz.validate([state.email, password])));
  }

  /// Handle form submission
  Future<void> signInWithEmailAndPassword() async {
    if (!state.status.isValidated) {
      return;
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
