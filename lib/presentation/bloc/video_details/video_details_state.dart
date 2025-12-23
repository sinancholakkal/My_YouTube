part of 'video_details_bloc.dart';

@immutable
sealed class VideoDetailsState {}

final class VideoDetailsInitial extends VideoDetailsState {}

class VideoLoadingState extends VideoDetailsState {}

class VideoErrorState extends VideoDetailsState {
  final String message;

  VideoErrorState({required this.message});
}

class VideoLoadedState extends VideoDetailsState {
  final yt.Video video;
  final String like;
  final String dislike;
  final String view;
  final String date;

  VideoLoadedState({
    required this.video,
    required this.like,
    required this.dislike,
    required this.view,
    required this.date,
  });
}
