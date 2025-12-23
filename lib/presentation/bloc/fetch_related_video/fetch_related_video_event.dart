part of 'fetch_related_video_bloc.dart';

class FetchRelatedVideoEvent {}

class FetchRelatedVideo extends FetchRelatedVideoEvent {
  final String videoId;

  FetchRelatedVideo({required this.videoId});
}
