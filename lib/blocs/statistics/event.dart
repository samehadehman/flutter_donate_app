import 'package:equatable/equatable.dart';

abstract class StatisticsEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class FetchAssociationCountEvent extends StatisticsEvent {
    // final String token;

    // FetchAssociationCountEvent(this.token);

}

abstract class DonationEvent {}

class FetchDonationTotalEvent extends DonationEvent {}


abstract class EndedCampaignsEvent {}

class FetchEndedCampaignsEvent extends EndedCampaignsEvent {}



abstract class InKindEvent {}

class FetchInkindEvent extends InKindEvent {}

