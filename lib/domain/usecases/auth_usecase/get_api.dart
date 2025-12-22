import 'package:googleapis/youtube/v3.dart';
import 'package:my_youtube/domain/repositories/auth_repo/auth_repo.dart';

class GetApiUseCase {
  final AuthRepo authRepo;

  GetApiUseCase(this.authRepo);

  Future<YouTubeApi?> call() async {
    return await authRepo.getApi();
  }
}
