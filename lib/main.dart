import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/auth/login_cubit.dart';
import 'package:hello/pages/VolunteerProfileDetailsPage.dart';
import 'package:hello/pages/forget_pass.dart';
import 'package:hello/pages/profileEditPage.dart';
import 'package:hello/pages/reset_pass.dart';
import 'package:hello/pages/verification.dart';
import 'package:hello/pages/volunteer_profile_form_page.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/pages/home_page.dart';
import 'package:hello/pages/loginpage.dart';
import 'package:hello/pages/signuppage.dart';
import 'blocs/auth/auth_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => AuthBloc(authService: AuthService())),
      ],
      child: MaterialApp(
    
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/loginpage': (context) => LoginPage(),
          '/signuppage': (context) => Signuppage(),
          '/home': (context) => HomePage(),
          '/forget1': (context) => ForgotPasswordPage(),
          '/forget2': (context) => ResetPasswordPage(email: '',),
          '/forget3': (context) => VerificationPage(email: '',),
          '/profileedit': (context) => ProfileEditPage(),
       //    '/volunteerform': (context) => VolunteerProfileFormPage(data: {},),
       //   '/volunteerdetail': (context) => VolunteerProfileDetailsPage(data: {},),
        },

      
      ),
    );
  }
}