import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/voluntingCamp/task_event.dart';
import 'package:hello/blocs/voluntingCamp/task_state.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   final CampaignService service;

//   TaskBloc(this.service) : super(TaskInitial()) {
//     on<FetchTaskDetails>((event, emit) async {
      
//       emit(TaskLoading());
//       try {
//            final prefs = await SharedPreferences.getInstance();
//           final token = prefs.getString('token') ?? '';
//         final task = await service.getTaskDetails(event.taskId, token);
//         emit(TaskLoaded(task));
//       } catch (e) {
//         emit(TaskError(e.toString()));
//       }
//     });
//         on<VolunteerForTask>(_onVolunteerForTask);
//   }
//      Future<void> _onVolunteerForTask(
//       VolunteerForTask event, Emitter<TaskState> emit) async {
//     try {
//        final prefs = await SharedPreferences.getInstance();
//           final token = prefs.getString('token') ?? '';
//       final message =
//           await service.volunteerForTask(event.taskId, token);

          
//       emit(VolunteerSuccess(message));
//     } catch (e) {
//       emit(TaskError(e.toString()));
//     }
//   }
// }

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CampaignService service;

  TaskBloc(this.service) : super(TaskInitial()) {
    on<FetchTaskDetails>((event, emit) async {
      
      emit(TaskLoading());
      try {
           final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
final taskId = prefs.getInt('task_id') ?? 0;
        final task = await service.getTaskDetails(taskId, token);
        emit(TaskLoaded(task));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
        on<VolunteerForTask>(_onVolunteerForTask);
        on<UpdateTaskStatus>(_onUpdateTask);
       
  }
     Future<void> _onVolunteerForTask(
      VolunteerForTask event, Emitter<TaskState> emit) async {
    try {
       final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
final taskId = prefs.getInt('task_id') ?? 0;
 
      final message =
          await service.volunteerForTask(taskId, token);

          
      emit(VolunteerSuccess(message));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
    
  }

   Future<void> _onUpdateTask(
      UpdateTaskStatus event, Emitter<TaskState> emit) async {
    emit(TaskStatusUpdating());
    try {
         final prefs = await SharedPreferences.getInstance();
        //   final token = prefs.getString('token') ?? '';
// final taskId = prefs.getInt('task_id') ?? 0;

final statusId = prefs.getInt('status_id') ?? 0;
      final updatedTask = await service.updateTaskStatus(
        taskId: event.taskId,
        // token: token,
        statusId: event.statusId,
      );
      //خزن الحالة الجديدة محليا
          await prefs.setInt('status_${event.taskId}', statusId);

      emit(TaskStatusUpdated(updatedTask));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
 
}

