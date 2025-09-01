import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_event.dart';
import 'package:hello/blocs/forgetpass/forget_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/verification.dart';
import 'package:hello/widgets/elevatedButton.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: Scaffold(
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
                        children: [
                          Text(
                            'نسيت كلمة المرور',
                            style: TextStyle(
                              color: zeti,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Zain',
                            ),
                          ),
                          const SizedBox(height: 9),
                          Container(height: 2, width: 110, color: zeti),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: emailController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "أدخل بريدك الإلكتروني",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Light_Green, width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: zeti, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                      listener: (context, state) {
                        if (state is ForgotPasswordFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor:
                                  const Color.fromARGB(255, 247, 119, 134),
                            ),
                          );
                        }
                
                        if (state is ForgotPasswordSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  VerificationPage(email: state.email),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            ElevatedButtonWidget(
                              textElevated: 'التالي',
                              height: 40,
                              width: 45,
                              onPressed: () {
                                final email = emailController.text.trim();
                
                                if (email.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("الرجاء إدخال البريد الإلكتروني"),
                                      backgroundColor:
                                          Color.fromARGB(255, 247, 119, 134),
                                    ),
                                  );
                                  return;
                                }
                
                                final emailRegex = RegExp(
                                    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                                if (!emailRegex.hasMatch(email)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "الرجاء إدخال بريد إلكتروني صالح"),
                                      backgroundColor:
                                          Color.fromARGB(255, 247, 119, 134),
                                    ),
                                  );
                                  return;
                                }
                
                                context
                                    .read<ForgotPasswordBloc>()
                                    .add(SubmitEmailEvent(email));
                              },
                            ),
                            if (state is ForgotPasswordLoading)
                              const Positioned(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
