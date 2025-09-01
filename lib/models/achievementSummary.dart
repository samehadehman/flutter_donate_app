class AchievementSummary {
  final int totalCampaigns;
  final String totalVolunteeringHours;
  final int totalDonations;

  AchievementSummary({
    required this.totalCampaigns,
    required this.totalVolunteeringHours,
    required this.totalDonations,
  });

  factory AchievementSummary.fromJson(Map<String, dynamic> json) {
    return AchievementSummary(
      totalDonations: json['total donations'] ?? 0,
      totalVolunteeringHours: json['total volunting hours']?.toString() ?? '0',
      totalCampaigns: json['total campaigns'] ?? 0,
    );
  }
}
