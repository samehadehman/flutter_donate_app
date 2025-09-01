import 'package:bloc/bloc.dart';
import 'package:hello/blocs/achievement/myvolounting_event.dart';
import 'package:hello/blocs/achievement/myvolounting_state.dart';
import 'package:hello/services/myvolounting_service.dart';

class VolunteerBloc extends Bloc<VolunteerEvent, VolunteerState> {
  final MyVolunteerService volunteerService;

  VolunteerBloc({required this.volunteerService}) : super(VolunteerLoading()) {
    on<LoadVolunteers>((event, emit) async {
      emit(VolunteerLoading());
      try {
        final volunteers = await volunteerService.fetchVolunteers();
        emit(VolunteerLoaded(volunteers));
      } catch (e) {
        emit(VolunteerError(e.toString()));
      }
    });
  }
}
