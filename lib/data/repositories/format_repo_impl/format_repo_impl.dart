import 'package:my_youtube/data/datasource/format_datasource/format_datasource.dart';
import 'package:my_youtube/domain/repositories/formating/formating_repo.dart';

class FormatRepoImpl implements FormatingRepo {
  final FormatDataSource dataSource;

  FormatRepoImpl({required this.dataSource});
  @override
  String formatCount(String count) {
    return dataSource.formatCount(count);
  }

  @override
  String formatTime(DateTime time) {
    return dataSource.formatDate(time);
  }
}
