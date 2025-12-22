import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart';

abstract class AuthRepo {
  Future<bool> signIn();
  Future<bool> signOut();
  Future<GoogleSignInAccount?> getCurrentUser();
  Future<YouTubeApi?> getApi();
  Future<bool> tryAutoLogin();
}
