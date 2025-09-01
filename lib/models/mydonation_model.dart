class Donation {
  final String campaignName;
  final String donationTime;

  Donation({required this.campaignName, required this.donationTime});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      campaignName: json['campiagn name'] ?? 'غير محدد',
      donationTime: json['donation time'] ?? '',
    );
  }
}
