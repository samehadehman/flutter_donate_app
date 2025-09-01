import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/emergency/emergency_campaigns_event.dart';
import 'package:hello/blocs/emergency/emergency_campaigns_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello/services/emergency_campaigns_service.dart';

class EmergencyCampaignsBloc extends Bloc<EmergencyCampaignsEvent, EmergencyCampaignsState> {
  final EmergencyCampaignsService service;

  EmergencyCampaignsBloc(this.service) : super(EmergencyCampaignsInitial()) {
    on<FetchEmergencyCampaignsEvent>(_onFetch);
  }

  Future<void> _onFetch(
    FetchEmergencyCampaignsEvent event,
    Emitter<EmergencyCampaignsState> emit,
  ) async {
    emit(EmergencyCampaignsLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      if (token.isEmpty) {
        emit(EmergencyCampaignsError('التوكن غير موجود'));
        return;
      }

      final data = await service.getEmergencyCampaigns(token);
      if (data != null) {
        emit(EmergencyCampaignsLoaded(data));
      } else {
        emit(EmergencyCampaignsError('فشل تحميل الحالات الطارئة'));
      }
    } catch (e) {
      emit(EmergencyCampaignsError(e.toString()));
    }
  }
}
