class WalletModel {
  final int? userId;
  final int? id;
  final int walletValue;
  final DateTime createdAt;
  final DateTime? updatedAt;

  WalletModel({
    this.userId,
    this.id,
    required this.walletValue,
    required this.createdAt,
    this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      userId: json['user_id'],
      id: json['id'],
      walletValue: int.tryParse(json['wallet_value'].toString()) ?? 0,
      createdAt: DateTime.tryParse(
            json['created_at'] ?? json['wallet_careated_date']
          ) ?? DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
