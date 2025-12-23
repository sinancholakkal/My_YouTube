part of 'video_details_bloc.dart';

@immutable
sealed class VideoDetailsEvent {}

class FetchVideoDetailsevent extends VideoDetailsEvent {
  final String videoId;

  FetchVideoDetailsevent({required this.videoId});
}
