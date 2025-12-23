part of 'fetch_related_video_bloc.dart';

@immutable
sealed class FetchRelatedVideoState {}

final class FetchRelatedVideoInitial extends FetchRelatedVideoState {}

class FetchRelatedVideoLoading extends FetchRelatedVideoState {}

class FetchRelatedVideoLoaded extends FetchRelatedVideoState {
  final List<yt.Video> videos;
  FetchRelatedVideoLoaded({required this.videos});
}

class FetchRelatedVideoError extends FetchRelatedVideoState {
  final String message;
  FetchRelatedVideoError({required this.message});
}
