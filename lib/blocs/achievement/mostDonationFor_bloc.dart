import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/achievement/mostDonationFor_event.dart';
import 'package:hello/blocs/achievement/mostDonationFor_state.dart';
import 'package:hello/services/mostDonationFor_service.dart';

class ImpactCampaignBloc extends Bloc<ImpactCampaignEvent, ImpactCampaignState> {
  final ImpactCampaignService service;

  ImpactCampaignBloc({required this.service}) : super(ImpactCampaignLoading()) {
    on<LoadImpactCampaigns>((event, emit) async {
      emit(ImpactCampaignLoading());
      try {
        final campaigns = await service.fetchImpactCampaigns();
        emit(ImpactCampaignLoaded(campaigns));
      } catch (e) {
        emit(ImpactCampaignError(e.toString()));
      }
    });
  }
}