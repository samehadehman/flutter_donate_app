import 'package:hello/models/voluntingCampaignDetails_model.dart';

abstract class CampaignDetailsState {}
class DetailsInitial extends CampaignDetailsState {}
class DetailsLoading extends CampaignDetailsState {}
class DetailsLoaded extends CampaignDetailsState {
  final CampaignDetailsModel campaign;
  DetailsLoaded(this.campaign);
}
class DetailsError extends CampaignDetailsState {
  final String message;
  DetailsError(this.message);
}