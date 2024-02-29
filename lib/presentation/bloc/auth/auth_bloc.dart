import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/login.dart';
import 'package:movie_finder/domain/usecases/logout.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final LogoutUsecase _logoutUsecase;

  AuthBloc(this._loginUsecase, this._logoutUsecase) : super(const NotLoggedIn()) {
    on <LogIn> (onLogin);
    on <InitAuthState> (onInitAuthState);
    on <LogOut> (onLogout);
  }

  onLogin(LogIn event, Emitter<AuthState> emit) async {
    emit(const LoggingIn());

    final dataState = await _loginUsecase(params: event.loginParams);
    if(dataState is DataFailure) {
      emit(AuthError(dataState.error!.message));
    }

    if(dataState is DataSuccess) {
      emit(LoggedIn(dataState.data!.username));
    }
  }

  onInitAuthState(InitAuthState event, Emitter<AuthState> emit) {
    emit(const NotLoggedIn());
  }

  onLogout(LogOut event, Emitter<AuthState> emit) async {
    final dataState = await _logoutUsecase();
    if(dataState is DataFailure) {
      emit(AuthError(dataState.error!.message));
    }

    if(dataState is DataSuccess) {
      emit(const NotLoggedIn());
    }
  }
}