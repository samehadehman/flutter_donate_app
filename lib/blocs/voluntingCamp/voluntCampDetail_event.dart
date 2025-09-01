abstract class CampaignDetailsEvent {}
class FetchCampaignDetails extends CampaignDetailsEvent {
  final int campaignId;
  FetchCampaignDetails(this.campaignId);
}