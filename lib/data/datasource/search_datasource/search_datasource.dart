import 'dart:developer';

import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;

class SearchDataSource {
  Future<({String? nextPageToken, List<yt.Video> videos})> fetchsearchVideos(
    String query, {
    String? pageToken,
  }) async {
    log("Fetch search result");
    final api = await di.sl<GetApiUseCase>().call();
    try {
      final searchResponse = await api!.search.list(
        ['id'],
        q: query,
        maxResults: 10,
        type: ['video'],
        pageToken: pageToken,
      );
      if (searchResponse.items == null || searchResponse.items!.isEmpty) {
        return (videos: <yt.Video>[], nextPageToken: null);
      }
      final String? nextPageToken = searchResponse.nextPageToken;

      String videoIds = searchResponse.items!
          .map((item) => item.id?.videoId)
          .where((id) => id != null)
          .join(',');

      final videoDetailsResponse = await api.videos.list(
        ['snippet', 'statistics', 'contentDetails'],
        id: [videoIds],
      );

      return (
        videos: videoDetailsResponse.items ?? <yt.Video>[],
        nextPageToken: nextPageToken,
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
