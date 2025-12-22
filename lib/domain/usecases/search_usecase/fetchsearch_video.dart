import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';

class FetchSearchVideo {
  final SearchRepo searchRepo;
  FetchSearchVideo(this.searchRepo);

  Future<List<yt.Video>> call(String query) async {
    return await searchRepo.fetchsearchVideos(query);
  }
}
