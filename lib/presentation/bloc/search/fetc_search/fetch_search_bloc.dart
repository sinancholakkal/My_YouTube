import 'package:bloc/bloc.dart';
import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:meta/meta.dart';
import 'package:my_youtube/domain/repositories/search_repo/search_repo.dart';
import 'package:my_youtube/domain/usecases/search_usecase/fetchsearch_video.dart';

part 'fetch_search_event.dart';
part 'fetch_search_state.dart';

class FetchSearchBloc extends Bloc<FetchSearchEvent, FetchSearchState> {
  final FetchSearchVideo fetchSearchVideo;
  String? nextPageToken;
  String query = "";
  List<yt.Video> videos = [];
  FetchSearchBloc(this.fetchSearchVideo) : super(FetchSearchInitial()) {
    on<SearchEvent>((event, emit) async {
      emit(FetchSearchLoading());
      query = event.query;
      try {
        final response = await fetchSearchVideo.call(
          event.query,
          pageToken: nextPageToken,
        );
        nextPageToken = response.nextPageToken;
        videos.addAll(response.videos);
        emit(FetchSearchSuccess(videos));
      } catch (e) {
        emit(FetchSearchFailure(e.toString()));
      }
    });
    on<SearchNextPageEvent>((event, emit) async {
      emit(FetchSearchNextPageLoading());
      try {
        final response = await fetchSearchVideo.call(
          query,
          pageToken: nextPageToken,
        );
        nextPageToken = response.nextPageToken;
        videos.addAll(response.videos);
        emit(FetchSearchSuccess(videos));
      } catch (e) {
        emit(FetchSearchFailure(e.toString()));
      }
    });
  }
}
