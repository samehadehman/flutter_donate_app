import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_event.dart';
import 'package:hello/blocs/forgetpass/forget_state.dart';
import 'package:hello/services/forgetpass.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
 on<SubmitEmailEvent>((event, emit) async {
      final email = event.email.trim();

      // تحقق أولي إن البريد مش فاضي
      if (email.isEmpty) {
        emit(ForgotPasswordFailure("الرجاء إدخال البريد الإلكتروني"));
        return;
      }
         emit(ForgotPasswordLoading());
   
   try {
        final response = await ApiService.sendForgotPasswordEmail(email);

        if (response.status==1) { 
          emit(ForgotPasswordSuccess(response.data!.email));
        } else {
          emit(ForgotPasswordFailure(response.message));
        }
      } catch (e) {
 emit(ForgotPasswordFailure(e.toString().contains("422")
            ? "البريد الإلكتروني هذا غير موجود"
            : "البريد الإلكتروني هذا غير موجود"));
      //  emit(ForgotPasswordFailure(e.toString()));
      }
    });

on<SubmitCodeEvent>((event, emit) async {
  emit(ForgotPasswordLoading());
  try {
    final response = await ApiService.verifyCode(event.email, event.code);
    if (response.status == 1) {
      emit(CodeVerificationSuccess(event.code));
    } else {
      emit(ForgotPasswordFailure("الكود غير صحيح"));
    }
  } catch (e) {
    emit(ForgotPasswordFailure(e.toString()));
  }
});

  }
}

class SubmitCodeEvent extends ForgotPasswordEvent {
  final String email;
  final String code;

  SubmitCodeEvent({required this.email, required this.code});

  
  
   @override
  List<Object?> get props => [email, code];
  
}


class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordSubmitted>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        final response = await ApiService.resetPassword(event.email, event.password);
        if (response.status == 1) {
          emit(ResetPasswordSuccess(token: response.token, role: response.role));
        } else {
          emit(ResetPasswordFailure(message: response.message));
        }
      } catch (e) {
        emit(ResetPasswordFailure(message: e.toString()));
      }
    });
  }
}

