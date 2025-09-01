import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/models/wallet_model.dart';
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
on<UpdateWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        final result = await _service.updateWallet(wallet_value: event.amount);
        if (result != null) {
          final status = result['status'] ?? 0;
          final data = result['data'];
          final message = result['message'] ?? "خطأ غير معروف";

          if (status == 1 && data != null) {
            final updatedWallet = WalletModel.fromJson(Map<String, dynamic>.from(data));
            emit(WalletLoaded(updatedWallet));
          } else {
            emit(WalletError("فشل تعديل المحفظة: $message"));
          }
        } else {
          emit(WalletError("فشل تعديل المحفظة: لا يوجد رد من السيرفر"));
        }
      } catch (e) {
        emit(WalletError("حدث خطأ أثناء تعديل المحفظة: $e"));
      }
    });
  }
}