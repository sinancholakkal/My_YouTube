part of 'fetch_search_bloc.dart';

@immutable
sealed class FetchSearchEvent {}

class SearchEvent extends FetchSearchEvent {
  final String query;
  SearchEvent(this.query);
}
