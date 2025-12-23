import 'dart:developer';

import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:my_youtube/data/datasource/search_datasource/search_datasource.dart';
import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource searchDataSource;
  SearchRepoImpl(this.searchDataSource);
  @override
  Future<List<yt.Video>> fetchsearchVideos(String query) async {
    try {
      return await searchDataSource.fetchsearchVideos(query);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<yt.Video>> fetchsearchVideosNextPage() async {
    try {
      return await searchDataSource.fetchsearchVideosNextPage();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
