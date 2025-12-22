import 'package:googleapis/youtube/v3.dart' as yt;

abstract class SearchRepo {
  Future<({String? nextPageToken, List<yt.Video> videos})> fetchsearchVideos(
    String query, {
    String? pageToken,
  });
}
