import 'package:my_youtube/domain/repositories/auth_repo/auth_repo.dart';

class TryAutoLoginUseCase {
  final AuthRepo authRepo;

  TryAutoLoginUseCase(this.authRepo);

  Future<bool> call() async {
    return await authRepo.tryAutoLogin();
  }
}
