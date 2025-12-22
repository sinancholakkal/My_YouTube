import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';

class FetchSearchVideo {
  final SearchRepo searchRepo;
  FetchSearchVideo(this.searchRepo);

  Future<({String? nextPageToken, List<yt.Video> videos})> call(
    String query, {
    String? pageToken,
  }) async {
    return await searchRepo.fetchsearchVideos(query, pageToken: pageToken);
  }
}
