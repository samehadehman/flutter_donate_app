import 'package:equatable/equatable.dart';
import 'package:hello/models/countAssociation_model.dart';

class StatisticsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final AssociationCountModel  count;

  StatisticsLoaded(this.count);

  @override
  List<Object?> get props => [count];
}

class StatisticsError extends StatisticsState {
  final String message;

  StatisticsError(this.message);

  @override
  List<Object?> get props => [message];
}


abstract class InKindDonationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InKindDonationInitial extends InKindDonationState {}

class InKindDonationLoading extends InKindDonationState {}

class InKindDonationLoaded extends InKindDonationState {
  final TotalInkindDonation donation;

  InKindDonationLoaded(this.donation);

  @override
  List<Object?> get props => [donation];
}

class InKindDonationError extends InKindDonationState {
  final String message;

  InKindDonationError(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class DonationState extends Equatable {
  @override
  List<Object?> get props => [];
}



class DonationInitial extends DonationState {}

class DonationLoading extends DonationState {}

class DonationLoaded extends DonationState {
  final DonationTotalModel donation;

  DonationLoaded(this.donation);

  @override
  List<Object?> get props => [donation];
}

class DonationError extends DonationState {
  final String message;

  DonationError(this.message);

  @override
  List<Object?> get props => [message];
}
abstract class EndedCampaignsState {}

class EndedCampaignsInitial extends EndedCampaignsState {}

class EndedCampaignsLoading extends EndedCampaignsState {}

class EndedCampaignsLoaded extends EndedCampaignsState {
  final int totalEnded;
  EndedCampaignsLoaded(this.totalEnded);
}

class EndedCampaignsError extends EndedCampaignsState {
  final String message;
  EndedCampaignsError(this.message);
}
