import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_youtube/domain/repositories/formating/formating_repo.dart';
import 'package:my_youtube/domain/usecases/formating_usecase/format_count_usecase.dart';
import 'package:my_youtube/domain/usecases/formating_usecase/format_date_usecase.dart';
import 'package:my_youtube/presentation/di/get_it.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

part 'video_details_event.dart';
part 'video_details_state.dart';

class VideoDetailsBloc extends Bloc<VideoDetailsEvent, VideoDetailsState> {
  VideoDetailsBloc() : super(VideoDetailsInitial()) {
    final _yt = yt.YoutubeExplode();
    final _formatRepo = sl<FormatCountUseCase>();
    final _formatDate = sl<FormatDateUseCase>();
    on<FetchVideoDetailsevent>((event, emit) async {
      emit(VideoLoadingState());
      try {
        final video = await _yt.videos.get(event.videoId);
        final like = _formatRepo.call(video.engagement.likeCount.toString());
        final dislike = _formatRepo.call(
          video.engagement.dislikeCount.toString(),
        );
        final view = _formatRepo.call(video.engagement.viewCount.toString());
        final date = _formatDate.call(video.uploadDate!);
        emit(
          VideoLoadedState(
            video: video,
            like: like,
            dislike: dislike,
            view: view,
            date: date,
          ),
        );
      } catch (e) {
        log("something issue while fetching details of video $e");
        emit(VideoErrorState(message: "Something went wrong"));
      }
    });
  }
}
