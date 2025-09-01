import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/voluntingCamp/voluntCamp_event.dart';
import 'package:hello/blocs/voluntingCamp/voluntCamp_state.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignService campaignService;

  CampaignBloc(this.campaignService) : super(CampaignInitial()) {
    on<FetchCampaigns>((event, emit) async {
      emit(CampaignLoading());
      try {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
        final campaigns = await campaignService.getAllCampaigns(token);
        emit(CampaignLoaded(campaigns));
      } catch (e) {
        emit(CampaignError(e.toString()));
      }
    });
  }
}
