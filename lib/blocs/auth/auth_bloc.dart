import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/user/user_model.dart';
import '../../repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AppStarted());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is Login) {
      yield* _mapLoginToState();
    } else if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      var currentUser = await _authRepository.getCurrentUser();
      // If the current user is not logged in, log them in anonymously
      currentUser ??= await _authRepository.loginAnonymously();
      final anonymousUser = await _authRepository.isAnonymous();

      if (anonymousUser) {
        yield Anonymous(user: currentUser);
      } else {
        yield Authenticated(user: currentUser);
      }
    } on Exception catch (error) {
      print(error);

      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoginToState() async* {
    try {
      final currentUser = await _authRepository.getCurrentUser();
      yield Authenticated(user: currentUser);
    } on Exception catch (error) {
      print(error);

      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLogoutToState() async* {
    try {
      await _authRepository.logout();
      yield* _mapAppStartedToState();
    } on Exception catch (error) {
      print(error);

      yield Unauthenticated();
    }
  }
}
