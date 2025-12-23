import 'dart:developer';

import 'package:my_youtube/domain/usecases/auth_usecase/get_api.dart';
import 'package:my_youtube/presentation/di/get_it.dart' as di;
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class SearchDataSource {
  final _yt = explode.YoutubeExplode();
  yt.VideoSearchList? _currentSearchList;

  Future<List<yt.Video>> fetchsearchVideos(String query) async {
    try {
      _currentSearchList = await _yt.search.search(query);
      return _currentSearchList!.toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<List<yt.Video>> fetchsearchVideosNextPage() async {
    try {
      final nextbatch = await _currentSearchList!.nextPage();
      _currentSearchList = nextbatch;
      return nextbatch!.toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
  // Future<({String? nextPageToken, List<yt.Video> videos})> fetchsearchVideos(
  //   String query, {
  //   String? pageToken,
  // }) async {
  //   log("Fetch search result");
  //   final api = await di.sl<GetApiUseCase>().call();
  //   try {
  //     final searchResponse = await api!.search.list(
  //       ['id'],
  //       q: query,
  //       maxResults: 10,
  //       type: ['video'],
  //       pageToken: pageToken,
  //     );
  //     if (searchResponse.items == null || searchResponse.items!.isEmpty) {
  //       return (videos: <yt.Video>[], nextPageToken: null);
  //     }
  //     final String? nextPageToken = searchResponse.nextPageToken;

  //     String videoIds = searchResponse.items!
  //         .map((item) => item.id?.videoId)
  //         .where((id) => id != null)
  //         .join(',');

  //     final videoDetailsResponse = await api.videos.list(
  //       ['snippet', 'statistics', 'contentDetails'],
  //       id: [videoIds],
  //     );

  //     return (
  //       videos: videoDetailsResponse.items ?? <yt.Video>[],
  //       nextPageToken: nextPageToken,
  //     );
  //   } catch (e) {
  //     log(e.toString());
  //     throw Exception(e);
  //   }
  // }
}
