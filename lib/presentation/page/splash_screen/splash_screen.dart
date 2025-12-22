import 'package:flutter/material.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/logout.dart';
import 'package:my_youtube/domain/usecases/auth_usecase/try_auto_login.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;
import 'package:my_youtube/presentation/page/login_screen/login_screen.dart';
import 'package:my_youtube/presentation/page/tabs/tabs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAutoLogin();
  }

  Future<void> checkAutoLogin() async {
    // final logoutUseCase = LogoutUseCase(di.sl());
    // await logoutUseCase.call();
    final tryAutoLoginUseCase = TryAutoLoginUseCase(di.sl());
    final result = await tryAutoLoginUseCase.call();

    if (result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Tabs()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
