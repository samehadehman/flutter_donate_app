// blocs/search/search_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/search/search_event.dart';
import 'package:hello/blocs/search/search_state.dart';
import 'package:hello/services/search_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService searchService;

  SearchBloc(this.searchService) : super(SearchInitial()) {
    on<SearchCampaignsEvent>((event, emit) async {
      print("🟢 Event received: ${event.query}");

      emit(SearchLoading());
      try {
        final campaigns = await searchService.searchCampaigns(event.query, event.token);
        print("🟢 Campaigns loaded: ${campaigns.length}");
        emit(SearchLoaded(campaigns));
      } catch (e) {
        print("❌ Bloc error: $e");
        emit(SearchError(e.toString()));
      }
    });
  }
}
