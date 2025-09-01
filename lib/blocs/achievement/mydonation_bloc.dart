import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/achievement/mydonation_event.dart';
import 'package:hello/blocs/achievement/mydonation_state.dart';
import 'package:hello/services/mydonation_service.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final MyDonationService donationService;

  DonationBloc({required this.donationService}) : super(DonationLoading()) {
    on<LoadDonations>((event, emit) async {
      emit(DonationLoading());
      try {
        final donations = await donationService.fetchDonations();
        emit(DonationLoaded(donations));
      } catch (e) {
        emit(DonationError(e.toString()));
      }
    });
  }
}
