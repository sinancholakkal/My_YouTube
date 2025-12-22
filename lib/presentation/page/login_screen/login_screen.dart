import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_youtube/presentation/bloc/auth/login/auth_login_bloc.dart';
import 'package:my_youtube/presentation/page/tabs/tabs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthLoginBloc, AuthLoginState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Tabs()),
            );
          }
        },
        child: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthLoginBloc>().add(AuthLoginWithGoogleEvent());
              },
              child: Text("Login"),
            ),
          ),
        ),
      ),
    );
  }
}
