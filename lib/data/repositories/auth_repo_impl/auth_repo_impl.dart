import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:my_youtube/data/datasource/auth_datasource/auth_datasource.dart';
import 'package:my_youtube/domain/repositories/auth_repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl(this.authDataSource);

  @override
  Future<bool> signIn() async {
    return await authDataSource.signIn();
  }

  @override
  Future<bool> signOut() async {
    return await authDataSource.signOut();
  }

  @override
  Future<GoogleSignInAccount?> getCurrentUser() async {
    return authDataSource.currentUser();
  }

  @override
  Future<YouTubeApi?> getApi() async {
    return authDataSource.api();
  }

  @override
  Future<bool> tryAutoLogin() async {
    return await authDataSource.tryAutoLogin();
  }
}
