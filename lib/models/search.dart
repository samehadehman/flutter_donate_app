class Campaign {
  final int id;
  final String title;
  final double amountRequired;
  final String donationAmount;
  final String photo;
  final String status;
  final String timeToEnd;
  final String type;
  final double amountToComplete;

  Campaign({
    required this.id,
    required this.title,
    required this.amountRequired,
    required this.donationAmount,
    required this.photo,
    required this.status,
    required this.timeToEnd,
    required this.type,
    required this.amountToComplete,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      title: json['title'],
      amountRequired: (json['amount_required']).toDouble(),
      donationAmount: json['donation_amount'],
      photo: json['photo'],
      status: json['campaign_status_id']['campaign_status_type'],
      timeToEnd: json['compaigns_time_to_end'],
      type: json['type'],
      amountToComplete: (json['amount_to_Complete']).toDouble(),
    );
  }
}
