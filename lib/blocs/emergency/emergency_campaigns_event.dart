import 'package:equatable/equatable.dart';

abstract class EmergencyCampaignsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchEmergencyCampaignsEvent extends EmergencyCampaignsEvent {}
