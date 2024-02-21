import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/login.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;

  LoginBloc(this._loginUsecase) : super(const NotLoggedIn()) {
    on <LogIn> (onLogin);
    on <InitAuthState> (onInitAuthState);
  }

  onLogin(LogIn event, Emitter<AuthState> emit) async {
    emit(const LoggingIn());

    final dataState = await _loginUsecase(params: event.loginParams);
    if(dataState is DataFailure) {
      emit(LoginError(dataState.error!.message));
    }

    if(dataState is DataSuccess) {
      emit(const LoggedIn());
    }
  }

  onInitAuthState(InitAuthState event, Emitter<AuthState> emit) {
    emit(const NotLoggedIn());
  }
}