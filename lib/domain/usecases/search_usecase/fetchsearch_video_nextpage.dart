import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class FetchSearchVideoNextPage {
  final SearchRepo searchRepo;
  FetchSearchVideoNextPage(this.searchRepo);

  Future<List<yt.Video>> call() async {
    return await searchRepo.fetchsearchVideosNextPage();
  }
}
