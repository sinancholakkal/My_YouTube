part of 'auth_login_bloc.dart';

@immutable
sealed class AuthLoginState {}

final class AuthLoginInitial extends AuthLoginState {}

class AuthLoginLoading extends AuthLoginState {}

class AuthLoginSuccess extends AuthLoginState {}

class AuthLoginFailure extends AuthLoginState {
  final String message;

  AuthLoginFailure({required this.message});
}
