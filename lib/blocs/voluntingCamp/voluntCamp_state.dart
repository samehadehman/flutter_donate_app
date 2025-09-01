import 'package:equatable/equatable.dart';
import 'package:hello/models/voluntingCampaigns_model.dart';

abstract class CampaignState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CampaignInitial extends CampaignState {}

class CampaignLoading extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<CampaignModel> campaigns;

  CampaignLoaded(this.campaigns);

  @override
  List<Object?> get props => [campaigns];
}

class CampaignError extends CampaignState {
  final String message;

  CampaignError(this.message);

  @override
  List<Object?> get props => [message];
}
