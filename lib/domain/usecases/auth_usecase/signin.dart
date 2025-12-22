import 'package:my_youtube/domain/repositories/auth_repo/auth_repo.dart';

class SignInUseCase {
  final AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  Future<bool> call() async {
    return await authRepo.signIn();
  }
}
