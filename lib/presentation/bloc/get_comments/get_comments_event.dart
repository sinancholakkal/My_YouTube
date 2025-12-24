part of 'get_comments_bloc.dart';

@immutable
sealed class GetCommentsEvent {}

class GetComments extends GetCommentsEvent {
  final yt.Video video;
  GetComments({required this.video});
}
