import 'package:bloc/bloc.dart';
import 'package:challengesapp/domain/authentication/email.dart';
import 'package:challengesapp/domain/authentication/password.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        password: password, status: Formz.validate([state.email, password])));
  }
}
