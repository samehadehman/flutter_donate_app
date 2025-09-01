import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/statistics/event.dart';
import 'package:hello/blocs/statistics/state.dart';
import 'package:hello/services/statistics_home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsService service;

  StatisticsBloc(this.service) : super(StatisticsInitial()) {
    on<FetchAssociationCountEvent>((event, emit) async {
      emit(StatisticsLoading());
      try {
            final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('auth_token') ?? '';
print('Token: $token');

if (token.isEmpty) {
  emit(StatisticsError('التوكن غير موجود'));
  return;
}

        final data = await service.getAssociationCount(token);
       if (data != null) {
          emit(StatisticsLoaded(data)); // هون مررنا الـ data
        } else {
          emit(StatisticsError("فشل تحميل البيانات"));
        }
      } catch (e) {
        emit(StatisticsError(e.toString()));
      }
    });


}
}


class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final DonationService service;

  DonationBloc(this.service) : super(DonationInitial()) {
    on<FetchDonationTotalEvent>((event, emit) async {
      emit(DonationLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token') ?? '';
        print('Token: $token');

        final data = await service.getDonationTotal(token);
        if (data != null) {
          emit(DonationLoaded(data));
        } else {
          emit(DonationError("فشل تحميل التبرعات"));
        }
      } catch (e) {
        emit(DonationError(e.toString()));
      }
    });
  }
}


class InKindBloc extends Bloc<InKindEvent, InKindDonationState> {
  final InKindService service;

  InKindBloc(this.service) : super(InKindDonationInitial()) {
    on<FetchInkindEvent>((event, emit) async {
      emit(InKindDonationLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token') ?? '';
        print('Token: $token');

        final data = await service.gettotalInkindDonations(token);
        if (data != null) {
          emit(InKindDonationLoaded(data));
        } else {
          emit(InKindDonationError("فشل تحميل التبرعات"));
        }
      } catch (e) {
        emit(InKindDonationError(e.toString()));
      }
    });
  }
}


class EndedCampaignsBloc extends Bloc<EndedCampaignsEvent, EndedCampaignsState> {
  final EndedCampaignsService service;

  EndedCampaignsBloc(this.service) : super(EndedCampaignsInitial()) {
    on<FetchEndedCampaignsEvent>(_onFetchEndedCampaigns);
  }

  Future<void> _onFetchEndedCampaigns(
      FetchEndedCampaignsEvent event, Emitter<EndedCampaignsState> emit) async {
    emit(EndedCampaignsLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      print('Token: $token');

      if (token.isEmpty) {
        emit(EndedCampaignsError('التوكن غير موجود'));
        return;
      }

      final data = await service.getEndedCampaigns(token);
      if (data != null) {
          print("Total Ended from model: ${data.totalEnded}");

        emit(EndedCampaignsLoaded(data.totalEnded));
      } else {
          print("Service returned null");

        emit(EndedCampaignsError("فشل تحميل الحملات المنتهية"));
      }
    } catch (e) {
      emit(EndedCampaignsError(e.toString()));
    }
  }
}