class Volunteer {
  final String campaignName;
  final String volunteeringTime;

  Volunteer({
    required this.campaignName,
    required this.volunteeringTime,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      campaignName: json['campiagn name'] ?? 'غير محدد',
      volunteeringTime: json['volunting time'] ?? '',
    );
  }
}
