abstract class TaskEvent {}

class FetchTaskDetails extends TaskEvent {
  final int taskId;
  final String token;

  FetchTaskDetails({required this.taskId, required this.token});
}
