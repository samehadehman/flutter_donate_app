
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/auth/auth_bloc.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/widgets/elevatedButton.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

        bool _obscurePassword = true; // لإخفاء/إظهار كلمة المرور

  void _onSignupPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('كلمة المرور وتأكيدها غير متطابقين'),
            backgroundColor: Color.fromARGB(255, 247, 119, 134),
          ),
        );
        return;
      }
      context.read<AuthBloc>().add(RegisterRequested(
            name: nameController.text.trim(),
            phone: phoneController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(), 
          confirmPassword: confirmPasswordController.text.trim(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // استخدم addPostFrameCallback لتجنب AssertionError
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) =>  HomePage()),
              );
            });
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
            Image.asset(
              'assets/images/Login.png',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 318, right: 25, left: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          Text(
                            'إنشاء حساب جديد',
                            style: TextStyle(
                              color: dark_Green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Zain',
                            ),
                          ),
                          const SizedBox(height: 9),
                          Container(
                            height: 2,
                            width: 110,
                            color: dark_Green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'الاسم',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Light_Green, width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: zeti, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يرجى إدخال الاسم';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: phoneController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'الرقم',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Light_Green, width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: zeti, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يرجى إدخال الرقم';
                        }
                        if (!RegExp(r'^\d{8,15}$').hasMatch(value.trim())) {
                          return 'يرجى إدخال رقم صحيح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'البريد الالكتروني',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Light_Green, width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: zeti, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يرجى إدخال البريد';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) {
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
                      obscureText:_obscurePassword,// لإخفاء/إظهار كلمة المرور,
                      decoration: InputDecoration(
                        hintText: 'كلمة المرور',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Light_Green, width: 1.5),
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
                          return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: confirmPasswordController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'تأكيد كلمة المرور',
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Light_Green, width: 1.5),
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
                        if (value == null || value.isEmpty) {
                          return 'يرجى تأكيد كلمة المرور';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButtonWidget(
                          textElevated: 'إنشاء حساب',
                          height: 40,
                          width: 45,
                          onPressed: () => _onSignupPressed(context),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/loginpage');
                          },
                          child: Text(
                            "سجل دخولك",
                            style: TextStyle(
                              fontSize: 18,
                              color: dark_Green,
                              fontFamily: 'Zain',
                            ),
                          ),
                        ),
                        Text(
                          ' لديك حساب؟ ',
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

