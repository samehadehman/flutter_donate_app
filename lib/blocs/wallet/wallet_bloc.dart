import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/services/wallet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'wallet_event.dart';


class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletService _service;

  WalletBloc(this._service) : super(WalletInitial()) {
    on<FetchWallet>((event, emit) async {
      emit(WalletLoading());
      try {
 final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';     
   if (token == null) throw Exception("Token not found");

        final wallet = await _service.getWallet(token);
        if (wallet != null) {
          emit(WalletLoaded(wallet));
        } else {
          emit(WalletEmpty());
        }
      } catch (e) {
        emit(WalletError("حدث خطأ أثناء جلب المحفظة"));
      }
    });

    on<CreateWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        final success = await _service.createWallet(
          wallet_value: event.amount,
          wallet_password: event.password,
          wallet_password_confirmation: event.confirmPassword,
        );

        if (success) {
 final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
                if (token == null) throw Exception("Token not found");

          final wallet = await _service.getWallet(token);
          if (wallet != null) {
            emit(WalletLoaded(wallet));
          } else {
            emit(WalletEmpty());
          }
        } else {
          emit(WalletError("فشل في إنشاء المحفظة"));
        }
      } catch (e) {
        emit(WalletError("حدث خطأ أثناء إنشاء المحفظة"));
      }
    });
  }
}