abstract class TaskEvent {}

class FetchTaskDetails extends TaskEvent {
  final int taskId;
  final String token;
  FetchTaskDetails({required this.taskId, required this.token});
}

class VolunteerForTask extends TaskEvent {
  final int taskId;
  final String token;
  VolunteerForTask({required this.taskId, required this.token});
}

class UpdateTaskStatus extends TaskEvent {
  final int taskId;
  // final String token;
  final int statusId;

  UpdateTaskStatus({
    required this.taskId,
    // required this.token,
    required this.statusId,
  });
}