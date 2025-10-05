import 'dart:math';

import 'package:kasi_care/features/auth/data/repository/auth_repository.dart';
import 'package:kasi_care/features/auth/pages/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(
        AuthUnauthenticated(
          message: e is FormatException ? e.message : "An error occurred",
        ),
      );
    }
  }

  Future<void> register(String email, String password, String fullname) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.register(email, password, fullname);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(
        AuthUnauthenticated(
          message: e is FormatException ? e.message : "An error occurred",
        ),
      );
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(
        AuthUnauthenticated(
          message: e is FormatException ? e.message : "An error occurred",
        ),
      );
    }
  }
}
