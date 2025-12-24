import 'dart:developer';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_youtube/presentation/bloc/auth/login/auth_login_bloc.dart';
import 'package:my_youtube/presentation/bloc/fetch_related_video/fetch_related_video_bloc.dart';
import 'package:my_youtube/presentation/bloc/get_channel_details/get_channel_details_bloc.dart';
import 'package:my_youtube/presentation/bloc/get_comments/get_comments_bloc.dart';
import 'package:my_youtube/presentation/bloc/video_details/video_details_bloc.dart';
import 'package:my_youtube/presentation/core/themes/app_themes.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;
import 'package:my_youtube/presentation/page/login_screen/login_screen.dart';
import 'package:my_youtube/presentation/page/splash_screen/splash_screen.dart';
import 'package:my_youtube/presentation/page/tabs/tabs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthLoginBloc(di.sl())),
        BlocProvider(create: (context) => GetChannelDetailsBloc()),
        BlocProvider(create: (context) => FetchRelatedVideoBloc()),
        BlocProvider(create: (context) => VideoDetailsBloc()),
        BlocProvider(create: (context) => GetCommentsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: SplashScreen(),
      ),
    );
  }
}
