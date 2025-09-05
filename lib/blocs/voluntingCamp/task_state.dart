import 'package:hello/models/voluntingCampaignDetails_model.dart';
import 'package:hello/models/voluntingCampaigns_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final Task task;
  TaskLoaded(this.task);
}


class VolunteerSuccess extends TaskState {
  final String message;
  VolunteerSuccess(this.message);
}

class TaskStatusUpdating extends TaskState {}

class TaskStatusUpdated extends TaskState {
  final TaskStatusModel taskStatus;
  TaskStatusUpdated(this.taskStatus);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
