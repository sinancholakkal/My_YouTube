import 'dart:developer';

import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;

class SearchDataSource {
  Future<List<yt.Video>> fetchsearchVideos(String query) async {
    log("Fetch search result");
    final api = await di.sl<GetApiUseCase>().call();
    try {
      final searchResponse = await api!.search.list(
        ['id'], // We only strictly need the ID here
        q: query, // The user's search text
        maxResults: 20,
        type: ['video'], // Ensure we don't get channels/playlists
      );
      if (searchResponse.items == null || searchResponse.items!.isEmpty) {
        return [];
      }

      String videoIds = searchResponse.items!
          .map((item) => item.id?.videoId)
          .where((id) => id != null)
          .join(',');

      final videoDetailsResponse = await api.videos.list(
        ['snippet', 'statistics', 'contentDetails'],
        id: [videoIds],
      );

      return videoDetailsResponse.items ?? [];
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
