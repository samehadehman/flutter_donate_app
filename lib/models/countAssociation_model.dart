//عدد الجمعيات
class AssociationCountModel {
  final int status;
  final int data;
  final String message;

  AssociationCountModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory AssociationCountModel.fromJson(Map<String, dynamic> json) {
    return AssociationCountModel(
      status: json['status'],
      data: json['data'],
      message: json['message'],
    );
  }
}
//التبرعات العينية
class TotalInkindDonation {
  final int status;
  final int data;
  final String message;

  TotalInkindDonation({
    required this.status,
    required this.data,
    required this.message,
  });

  factory TotalInkindDonation.fromJson(Map<String, dynamic> json) {
    return TotalInkindDonation(
      status: json['status'],
      data: json['data'],
      message: json['message'],
    );
  }
}
//اجمالي التبرعات
class DonationTotalModel {
  final int total;
  final String message;
  final int status;

  DonationTotalModel({
    required this.total,
    required this.message,
    required this.status,
  });

  factory DonationTotalModel.fromJson(Map<String, dynamic> json) {
    return DonationTotalModel(
      total: json['data'] ?? 0,
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}

class EndedCampaignsModel {

  final int totalEnded;

  EndedCampaignsModel({

    required this.totalEnded,
  });

  factory EndedCampaignsModel.fromJson(Map<String, dynamic> json) {
    return EndedCampaignsModel(

      totalEnded: json['data']['total_ended'] ?? 0,
    );
  }
}

