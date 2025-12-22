part of 'fetch_search_bloc.dart';

@immutable
sealed class FetchSearchState {}

final class FetchSearchInitial extends FetchSearchState {}

class FetchSearchLoading extends FetchSearchState {}

class FetchSearchSuccess extends FetchSearchState {
  final List<yt.Video> videos;
  FetchSearchSuccess(this.videos);
}

class FetchSearchFailure extends FetchSearchState {
  final String message;
  FetchSearchFailure(this.message);
}
