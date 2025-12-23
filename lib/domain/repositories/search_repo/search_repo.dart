import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

abstract class SearchRepo {
  Future<List<yt.Video>> fetchsearchVideos(String query);

  Future<List<yt.Video>> fetchsearchVideosNextPage();
}
