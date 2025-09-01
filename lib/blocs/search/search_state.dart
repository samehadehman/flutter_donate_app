// blocs/search/search_state.dart
import 'package:hello/models/search.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Campaign> campaigns;
  SearchLoaded(this.campaigns);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
