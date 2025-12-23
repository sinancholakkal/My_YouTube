import 'package:my_youtube/domain/repositories/formating/formating_repo.dart';

class FormatCountUseCase {
  final FormatingRepo formatingRepo;

  FormatCountUseCase(this.formatingRepo);

  String call(String count) {
    return formatingRepo.formatCount(count);
  }
}
