import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

part 'fetch_related_video_event.dart';
part 'fetch_related_video_state.dart';

class FetchRelatedVideoBloc
    extends Bloc<FetchRelatedVideoEvent, FetchRelatedVideoState> {
  FetchRelatedVideoBloc() : super(FetchRelatedVideoInitial()) {
    on<FetchRelatedVideo>((event, emit) async {
      emit(FetchRelatedVideoLoading());
      try {
        final video = await yt.YoutubeExplode().videos.get(event.videoId);
        final videos = await yt.YoutubeExplode().videos.getRelatedVideos(video);
        emit(FetchRelatedVideoLoaded(videos: videos?.toList() ?? []));
      } catch (e) {
        emit(FetchRelatedVideoError(message: e.toString()));
      }
    });
  }
}
