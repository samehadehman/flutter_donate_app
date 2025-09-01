class ImpactCampaign {
  final String campaignName;
  final int impactScore;

  ImpactCampaign({
    required this.campaignName,
    required this.impactScore,
  });

  factory ImpactCampaign.fromJson(Map<String, dynamic> json) {
    return ImpactCampaign(
      campaignName: json['campaign name'] ?? 'غير محدد',
      impactScore: json['impact score'] ?? 0,
    );
  }
}
