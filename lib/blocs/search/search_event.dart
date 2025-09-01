// blocs/search/search_event.dart
abstract class SearchEvent {}

class SearchCampaignsEvent extends SearchEvent {
  final String query;
  final String token;
  SearchCampaignsEvent(this.query, this.token);
}
