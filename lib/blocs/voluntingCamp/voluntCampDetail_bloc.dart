import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/voluntingCamp/voluntCampDetail_event.dart';
import 'package:hello/blocs/voluntingCamp/voluntCampDetail_state.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CampaignDetailsBloc extends Bloc<CampaignDetailsEvent, CampaignDetailsState> {
  final CampaignService service;
  CampaignDetailsBloc(this.service) : super(DetailsInitial()) {
    on<FetchCampaignDetails>((event, emit) async {
      emit(DetailsLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
        final campaign = await service.getCampaignDetails(event.campaignId , token);
        emit(DetailsLoaded(campaign));
      } catch (e) {
        emit(DetailsError(e.toString()));
      }
    });
  }
}