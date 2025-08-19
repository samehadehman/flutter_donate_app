import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_bloc.dart';
import 'package:hello/ui/view/case_form_page.dart';
import 'package:hello/ui/view/forget_pass.dart';
import 'package:hello/ui/view/reset_pass.dart';
import 'package:hello/ui/view/verification.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/ui/view/loginpage.dart';
import 'package:hello/ui/view/signuppage.dart';
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
         BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authService:AuthService()),
        ),
            BlocProvider(create: (_) => ForgotPasswordBloc()),

      ],

      child: MaterialApp(
    
        debugShowCheckedModeBanner: false,
        initialRoute: '/loginpage',
        routes: {
          '/loginpage': (context) => LoginPage(),
         '/signuppage': (context) => Signuppage(),
          '/home': (context) => HomePage(),
          '/forget1': (context) => ForgotPasswordPage(),
          '/forget2': (context) => ResetPasswordPage(email: '',),
          '/forget3': (context) => VerificationPage(email: '',),
          '/caseform': (context) => CaseFormPage(),
       //    '/volunteerform': (context) => VolunteerProfileFormPage(data: {},),
       //   '/volunteerdetail': (context) => VolunteerProfileDetailsPage(data: {},),
        },

      
      ),
    );
  }
}