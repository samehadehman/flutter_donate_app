import 'package:hello/models/scheduledTask_model.dart';

abstract class ScheduledTasksState {}

class ScheduledTasksLoading extends ScheduledTasksState {}

class ScheduledTasksLoaded extends ScheduledTasksState {
  final List<ScheduledTask> tasks;
  ScheduledTasksLoaded(this.tasks);
}

class ScheduledTasksError extends ScheduledTasksState {
  final String message;
  ScheduledTasksError(this.message);
}
