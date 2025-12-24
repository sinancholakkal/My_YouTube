part of 'get_comments_bloc.dart';

@immutable
sealed class GetCommentsState {}

final class GetCommentsInitial extends GetCommentsState {}

class GetCommentsLoadingState extends GetCommentsState {}

class GetCommentsLoadedState extends GetCommentsState {
  final List<dynamic> comments;
  final int commentCount;
  final bool disabled;
  GetCommentsLoadedState({
    required this.comments,
    required this.commentCount,
    required this.disabled,
  });
}

class GetCommentsErrorState extends GetCommentsState {
  final String message;
  GetCommentsErrorState({required this.message});
}
