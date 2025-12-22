import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/data/datasource/search_datasource/search_datasource.dart';
import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource searchDataSource;
  SearchRepoImpl(this.searchDataSource);
  @override
  Future<({String? nextPageToken, List<yt.Video> videos})> fetchsearchVideos(
    String query, {
    String? pageToken,
  }) async {
    return await searchDataSource.fetchsearchVideos(
      query,
      pageToken: pageToken,
    );
  }
}
