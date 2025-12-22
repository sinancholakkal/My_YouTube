import 'package:my_youtube/domain/repositories/auth_repo/auth_repo.dart';

class LogoutUseCase {
  final AuthRepo authRepo;

  LogoutUseCase(this.authRepo);

  Future<bool> call() async {
    return await authRepo.signOut();
  }
}
