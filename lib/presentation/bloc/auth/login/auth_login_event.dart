part of 'auth_login_bloc.dart';

@immutable
sealed class AuthLoginEvent {}

class AuthLoginWithGoogleEvent extends AuthLoginEvent {}
