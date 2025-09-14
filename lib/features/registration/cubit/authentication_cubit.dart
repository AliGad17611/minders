import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:minders/features/domain/use_cases/authentication_use_cases.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  final AuthenticationUseCases authenticationUseCases = AuthenticationUseCases();

  void login(String email, String password) async {
    emit(AuthenticationLoading());
    try {
      await authenticationUseCases.login(email, password);
      emit(AuthenticationSuccess());
      return;
    } on FirebaseAuthException catch (e) {
      log(e.toString());

      emit(AuthenticationFailure(error: e.message ?? ''));

      return;
    } catch (e) {
      log(e.toString());
      emit(AuthenticationFailure(error: e.toString()));
    }
  }

  void signup(String userName, String email, String password) async {
    emit(AuthenticationLoading());
    try {
      await authenticationUseCases.signup(userName, email, password);
      emit(AuthenticationSuccess());
    } catch (e) {
      emit(AuthenticationFailure(error: e.toString()));
    }
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(AuthenticationInitial());
    } catch (e) {
      emit(AuthenticationFailure(error: e.toString()));
    }
  }
}
