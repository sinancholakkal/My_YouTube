import 'dart:developer';

import 'package:bloc/bloc.dart';
// import 'package:googleapis/youtube/v3.dart' as yt;
// import 'package:googleapis/youtube/v3.dart';
import 'package:meta/meta.dart';
import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';
import 'package:my_youtube/domain/usecases/search_usecase/fetchsearch_video.dart';
import 'package:my_youtube/domain/usecases/search_usecase/fetchsearch_video_nextpage.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

part 'fetch_search_event.dart';
part 'fetch_search_state.dart';

class FetchSearchBloc extends Bloc<FetchSearchEvent, FetchSearchState> {
  final FetchSearchVideo fetchSearchVideo;
  final FetchSearchVideoNextPage fetchSearchVideoNextPage;
  String? nextPageToken;
  String query = "";
  List<yt.Video> videos = [];

  FetchSearchBloc(this.fetchSearchVideo, this.fetchSearchVideoNextPage)
    : super(FetchSearchInitial()) {
    on<SearchEvent>((event, emit) async {
      emit(FetchSearchLoading());
      query = event.query;
      try {
        log("Fetching search (NO QUOTA)...");

        // This call costs 0 Quota
        final response = await fetchSearchVideo.call(event.query);
        videos.addAll(response);
        emit(FetchSearchSuccess(videos));
      } catch (e) {
        emit(FetchSearchFailure(e.toString()));
      }
    });
    on<SearchNextPageEvent>((event, emit) async {
      emit(FetchSearchNextPageLoading());
      try {
        final response = await fetchSearchVideoNextPage.call();
        videos.addAll(response);
        emit(FetchSearchSuccess(videos));
      } catch (e) {
        emit(FetchSearchFailure(e.toString()));
      }
    });
  }
}
