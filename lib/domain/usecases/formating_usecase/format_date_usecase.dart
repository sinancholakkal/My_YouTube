import 'package:my_youtube/domain/repositories/formating/formating_repo.dart';

class FormatDateUseCase {
  final FormatingRepo formatingRepo;

  FormatDateUseCase(this.formatingRepo);

  String call(DateTime time) {
    return formatingRepo.formatTime(time);
  }
}
