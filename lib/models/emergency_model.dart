class EmergencyCampaign {
  final int id;
  final String title;
  final String location;
  final double donationAmount;
  final String photo;            // URL جاهز للعرض
  final String type;             // "association" | "individual"
  final int amountToComplete;

  EmergencyCampaign({
    required this.id,
    required this.title,
    required this.location,
    required this.donationAmount,
    required this.photo,
    required this.type,
    required this.amountToComplete,
  });

  factory EmergencyCampaign.fromJson(Map<String, dynamic> json) {
    String rawPhoto = '';
    final dynamic p = json['photo'];
    if (p is String) {
      rawPhoto = p;
    } else if (p is Map<String, dynamic>) {
      rawPhoto = p['photo']?.toString() ?? '';
    }

    if (rawPhoto.startsWith('http://localhost')) {
      rawPhoto = rawPhoto.replaceFirst('http://localhost', 'http://192.168.173.158');
    }

    return EmergencyCampaign(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      donationAmount: double.tryParse(json['donation_amount']?.toString() ?? '0') ?? 0.0,
      photo: rawPhoto,
      type: json['type']?.toString() ?? '',
      amountToComplete: (json['amount_to_Complete'] ?? json['amount_to_complete'] ?? 0) as int,
    );
  }
}

class EmergencyCampaignsResponse {
  final int status;
  final List<EmergencyCampaign> data;
  final String message;

  EmergencyCampaignsResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory EmergencyCampaignsResponse.fromJson(Map<String, dynamic> json) {
    final List list = (json['data'] as List? ?? []);
    return EmergencyCampaignsResponse(
      status: json['status'] ?? 0,
      data: list.map((e) => EmergencyCampaign.fromJson(e as Map<String, dynamic>)).toList(),
      message: json['message']?.toString() ?? '',
    );
  }
}
