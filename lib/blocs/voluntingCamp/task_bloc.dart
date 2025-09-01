import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/voluntingCamp/task_event.dart';
import 'package:hello/blocs/voluntingCamp/task_state.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CampaignService service;

  TaskBloc(this.service) : super(TaskInitial()) {
    on<FetchTaskDetails>((event, emit) async {
      emit(TaskLoading());
      try {
        final task = await service.getTaskDetails(event.taskId, event.token);
        emit(TaskLoaded(task));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
  }
}
