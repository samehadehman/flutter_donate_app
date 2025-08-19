import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/auth/auth_bloc.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/forget_pass.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/widgets/elevatedButton.dart';

class LoginPage extends StatefulWidget {
  static String id = "log";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true; // لإخفاء/إظهار كلمة المرور

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      context.read<AuthBloc>().add(
            LoginRequested(email: email, password: password),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {

          //  if (state is! AuthLoading) {
          //   Navigator.of(context, rootNavigator: true).pop();
          // }
          if (state is AuthLoading) {
            // ممكن نضيف Dialog تحميل هون إذا بدك
          } else if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) =>  HomePage()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: const Color.fromARGB(255, 247, 119, 134),
              ),
            );
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/Login.png', fit: BoxFit.cover),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 307, right: 25, left: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          Text(
                            'تسجيل الدخول',
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
                    TextFormField(
                      controller: emailController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "البريد الالكتروني",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Light_Green,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: zeti, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال البريد';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'البريد غير صالح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "كلمة المرور",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Light_Green,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: zeti, width: 2),
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: medium_Green,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'كلمة المرور قصيرة';
                        }
                        return null;
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "هل نسيت كلمة المرور؟",
                          style: TextStyle(
                            fontSize: 14,
                            color: dark_Green,
                            fontFamily: 'Zain',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButtonWidget(
                          textElevated: 'تسجيل الدخول',
                          height: 40,
                          width: 45,
                          onPressed: () => _onLoginPressed(context),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/signuppage');
                          },
                          child: Text(
                            "سجل الآن",
                            style: TextStyle(
                              fontSize: 18,
                              color: dark_Green,
                              fontFamily: 'Zain',
                            ),
                          ),
                        ),
                        Text(
                          'ليس لديك حساب؟ ',
                          style: TextStyle(
                            color: medium_Green,
                            fontSize: 16,
                            fontFamily: 'Zain',
                          ),
                        ),
                      ],
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
