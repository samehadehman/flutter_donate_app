import 'package:equatable/equatable.dart';
import 'package:hello/models/mydonation_model.dart';

abstract class DonationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DonationLoading extends DonationState {}

class DonationLoaded extends DonationState {
  final List<Donation> donations;

  DonationLoaded(this.donations);

  @override
  List<Object?> get props => [donations];
}

class DonationError extends DonationState {
  final String message;

  DonationError(this.message);

  @override
  List<Object?> get props => [message];
}
