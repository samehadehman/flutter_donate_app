import 'package:equatable/equatable.dart';

abstract class CampaignEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCampaigns extends CampaignEvent {
  // final String token;

  FetchCampaigns();

  // @override
  // List<Object?> get props => [token];
}
