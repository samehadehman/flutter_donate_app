class ScheduledTask {
  final int taskId;
  final String campaignName;
  final String taskName;
  final String campaignEndTime;
  final String status;

  ScheduledTask({
    required this.taskId,
    required this.campaignName,
    required this.taskName,
    required this.campaignEndTime,
    required this.status,
  });

  factory ScheduledTask.fromJson(Map<String, dynamic> json) {
    return ScheduledTask(
      taskId: json['task_id'] ?? 0,
      campaignName: json['campaign_name'] ?? '',
      taskName: json['task_name'] ?? '',
      campaignEndTime: json['campaign_end_time'] ?? '',
      status: json['status_id']?['status'] ?? '',
    );
  }
}
