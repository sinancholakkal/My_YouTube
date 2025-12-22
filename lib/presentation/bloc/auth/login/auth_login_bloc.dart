import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/signin.dart';

part 'auth_login_event.dart';
part 'auth_login_state.dart';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final SignInUseCase signInUseCase;
  AuthLoginBloc(this.signInUseCase) : super(AuthLoginInitial()) {
    on<AuthLoginWithGoogleEvent>((event, emit) async {
      emit(AuthLoginLoading());
      final result = await signInUseCase.call();
      try {
        if (result) {
          emit(AuthLoginSuccess());
        } else {
          log("Login cancelled");
          emit(AuthLoginFailure(message: "Login cancelled"));
        }
      } catch (e) {
        log(e.toString());
        emit(AuthLoginFailure(message: "Please try again later"));
      }
    });
  }
}
