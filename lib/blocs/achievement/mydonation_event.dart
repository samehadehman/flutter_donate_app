import 'package:equatable/equatable.dart';

abstract class DonationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDonations extends DonationEvent {}
