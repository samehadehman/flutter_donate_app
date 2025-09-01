import 'package:equatable/equatable.dart';
import 'package:hello/models/wallet_model.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletModel wallet;

  const WalletLoaded(this.wallet);

  @override
  List<Object?> get props => [wallet];
}

class WalletEmpty extends WalletState {}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object?> get props => [message];
}
