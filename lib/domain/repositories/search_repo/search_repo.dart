import 'package:googleapis/youtube/v3.dart' as yt;

abstract class SearchRepo {
  Future<List<yt.Video>> fetchsearchVideos(String query);
}
