
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_event.dart';
import 'package:hello/blocs/forgetpass/forget_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/loginpage.dart';
import 'package:hello/widgets/elevatedButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordPage extends StatefulWidget {
  
  final String code;
  final String email;

  const ResetPasswordPage({
    super.key,
    required this.code,
    required this.email,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onResetPressed(BuildContext context) {
    if (passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء تعبئة جميع الحقول"),
          backgroundColor: Color.fromARGB(255, 247, 119, 134),
        ),
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("كلمتا المرور غير متطابقتين"),
          backgroundColor: Color.fromARGB(255, 247, 119, 134),
        ),
      );
      return;
    }

    // إرسال الحدث للـ Bloc (نفس Bloc الفورغيت)
    context.read<ResetPasswordBloc>().add(
          ResetPasswordSubmitted(
            code: widget.code,
            email: widget.email,
            newpassword: passwordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) async {
        if (state is ResetPasswordSuccess) {
          // خزّن التوكن
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("auth_token", state.token);

          // رجّع المستخدم على صفحة تسجيل الدخول
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        } else if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: const Color.fromARGB(255, 247, 119, 134),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/Login.png', fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.only(top: 350, right: 25, left: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'إعادة تعيين كلمة المرور',
                              style: TextStyle(
                                color: dark_Green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Zain',
                              ),
                            ),
                            const SizedBox(height: 9),
                            Container(height: 2, width: 110, color: dark_Green),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "كلمة المرور الجديدة",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Light_Green, width: 1.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: zeti, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "تأكيد كلمة المرور",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Light_Green, width: 1.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: zeti, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      state is ForgotPasswordLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButtonWidget(
                              textElevated: 'إعادة تعيين',
                              height: 40,
                              width: 45,
                              onPressed: () => _onResetPressed(context),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

