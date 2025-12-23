import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class FetchSearchVideo {
  final SearchRepo searchRepo;
  FetchSearchVideo(this.searchRepo);

  Future<List<yt.Video>> call(String query, {String? pageToken}) async {
    return await searchRepo.fetchsearchVideos(query);
  }
}
