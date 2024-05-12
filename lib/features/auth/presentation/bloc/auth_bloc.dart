import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meoscleanarchitecture/core/usecase/usecase.dart';
import 'package:meoscleanarchitecture/features/auth/domain/entities/user.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/current_user.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/user_sign_in.dart';
import 'package:meoscleanarchitecture/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthGetCurrentUser>(_isUserLoggedIn);
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
          email: event.email, password: event.password, name: event.name),
    );

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }

  FutureOr<void> _isUserLoggedIn(
      AuthGetCurrentUser event, Emitter<AuthState> emit) async {
    final response = await _currentUser(NoParams());
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }
}
