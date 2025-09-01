import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_event.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_state.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ScheduledTasksBloc extends Bloc<ScheduledTasksEvent, ScheduledTasksState> {
  final CampaignService service;

  ScheduledTasksBloc(this.service) : super(ScheduledTasksLoading()) {
    on<FetchScheduledTasks>((event, emit) async {
      emit(ScheduledTasksLoading());
      try {
           final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
        final tasks = await service.getScheduledTasks(token);
        emit(ScheduledTasksLoaded(tasks));
      } catch (e) {
        emit(ScheduledTasksError(e.toString()));
      }
    });
  }
}
