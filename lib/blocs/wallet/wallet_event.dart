import 'package:equatable/equatable.dart';
import 'package:hello/models/wallet_model.dart';

abstract class WalletEvent {}
class FetchWallet extends WalletEvent {}
class CreateWallet extends WalletEvent {
  final double amount;
  final String password;
  final String confirmPassword;

  CreateWallet({required this.amount, required this.password, required this.confirmPassword});
}

abstract class WalletState {}
class WalletInitial extends WalletState {}
class WalletLoading extends WalletState {}
class WalletLoaded extends WalletState {
  final WalletModel wallet;
  WalletLoaded(this.wallet);
}
class WalletEmpty extends WalletState {}
class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}