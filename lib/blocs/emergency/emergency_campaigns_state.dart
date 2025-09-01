import 'package:equatable/equatable.dart';
import 'package:hello/models/emergency_model.dart';

abstract class EmergencyCampaignsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmergencyCampaignsInitial extends EmergencyCampaignsState {}

class EmergencyCampaignsLoading extends EmergencyCampaignsState {}

class EmergencyCampaignsLoaded extends EmergencyCampaignsState {
  final List<EmergencyCampaign> campaigns;
  EmergencyCampaignsLoaded(this.campaigns);

  @override
  List<Object?> get props => [campaigns];
}

class EmergencyCampaignsError extends EmergencyCampaignsState {
  final String message;
  EmergencyCampaignsError(this.message);

  @override
  List<Object?> get props => [message];
}
