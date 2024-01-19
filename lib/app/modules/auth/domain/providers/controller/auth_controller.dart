import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutor/app/modules/auth/domain/providers/repo/auth_repo.dart';
import 'package:tutor/app/modules/auth/domain/providers/state/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(super.state, this._authRepository);
  final AuthRepository _authRepository;

  Future<bool> register({
    required String email,
    required String userName,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      User? userCred = await _authRepository.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      if (userCred != null) {
        await userCred.updateDisplayName(userName.toString());

        await _authRepository.saveUserInfoToFirebase(
            userCred.uid, userName.toString(), email.toString());
        state = state.copyWith(isLoading: false, isAuth: true);
        return true;
      }
    } on AuthException catch (e) {
      state =
          state.copyWith(isLoading: false, isAuth: false, error: e.toString());
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        state = state.copyWith(
          isLoading: false,
          isAuth: true,
        );
        return true;
      } else {
        state = state.copyWith(
            isLoading: false, error: "Cannot retrieve user data");
        return false;
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message.toString());
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await _authRepository.signOut();
      state = state.copyWith(
        isAuth: false,
        error: null,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
