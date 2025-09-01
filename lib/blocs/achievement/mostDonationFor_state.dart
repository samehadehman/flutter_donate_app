import 'package:hello/models/mostDonationFor.dart';

abstract class ImpactCampaignState {}

class ImpactCampaignLoading extends ImpactCampaignState {}

class ImpactCampaignLoaded extends ImpactCampaignState {
  final List<ImpactCampaign> campaigns;
  ImpactCampaignLoaded(this.campaigns);
}

class ImpactCampaignError extends ImpactCampaignState {
  final String message;
  ImpactCampaignError(this.message);
}