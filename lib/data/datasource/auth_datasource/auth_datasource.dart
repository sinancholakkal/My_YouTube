import 'dart:developer';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart';

class AuthDataSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [YouTubeApi.youtubeScope],
  );

  YouTubeApi? _youTubeApi;
  GoogleSignInAccount? currentUser() {
    return _googleSignIn.currentUser;
  }

  YouTubeApi? api() {
    return _youTubeApi;
  }

  Future<bool> signIn() async {
    log("Signing in...");
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        log("User cancelled the sign-in");
        return false;
      } else {
        log("User signed in successfully");
      }
      await getApi();

      return true;
    } catch (error) {
      log("Login Error: $error");

      throw Exception(error);
    }
  }

  Future<void> getApi() async {
    final httpClient = await _googleSignIn.authenticatedClient();
    if (httpClient == null) return;

    _youTubeApi = YouTubeApi(httpClient);
  }

  Future<bool> tryAutoLogin() async {
    try {
      final account = await _googleSignIn.signInSilently();

      if (account != null) {
        await getApi();

        return true;
      }
    } catch (e) {
      log("Auto Login Failed: $e");
    }

    return false;
  }

  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      _youTubeApi = null;
      return true;
    } catch (error) {
      log("Logout Error: $error");
      throw Exception(error);
    }
  }
}
