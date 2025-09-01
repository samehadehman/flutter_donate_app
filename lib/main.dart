import 'package:dio/src/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_bloc.dart';
import 'package:hello/blocs/profile/mini_bloc.dart';
import 'package:hello/blocs/profile/mini_event.dart';
import 'package:hello/blocs/userinfo/userinfo_bloc.dart';
import 'package:hello/blocs/userinfo/userinfo_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_event.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_bloc.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_event.dart';
import 'package:hello/blocs/wallet/wallet_bloc.dart';
import 'package:hello/blocs/wallet/wallet_event.dart';
import 'package:hello/models/search.dart';
import 'package:hello/services/userInfo_service.dart';
import 'package:hello/services/userProfile_service.dart';
import 'package:hello/services/volunteerProfileForm_service.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:hello/services/wallet_service.dart';
import 'package:hello/ui/view/case_form_page.dart';
import 'package:hello/ui/view/forget_pass.dart';
import 'package:hello/ui/view/profilePage.dart';
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

   final  dio = Dio();
    return MultiBlocProvider(
      
     providers: [
         BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authService:AuthService()),
        ),
BlocProvider<ForgotPasswordBloc>(
          create: (context) => ForgotPasswordBloc(),
        ),
        BlocProvider<ResetPasswordBloc>(
          create: (context) => ResetPasswordBloc(),
        ),
      BlocProvider<VerifyCodeBloc>(
      create: (context) => VerifyCodeBloc(),
    ),
   BlocProvider(
  create: (_) => VolunteerProfileBloc(
    VolunteerService(dio),
    UserService(dio: dio),
  )..add(GetVolunteerProfileEvent()), // ✅ هاد السطر بجيب الملف من السيرفر أول ما يشتغل
),
        BlocProvider<UserInfoBloc>(
          create: (_) => UserInfoBloc(UserInfoService())..add(FetchUserInfo()),
        ),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(service: UserService(dio: Dio()))..add(LoadUser()),
        ),

        BlocProvider(
      create: (_) => WalletBloc(WalletService())..add(FetchWallet()),),

      BlocProvider(
        create: (context) => ScheduledTasksBloc(CampaignService())..add(FetchScheduledTasks()),
      ),
      ],

      child: MaterialApp(
    
        debugShowCheckedModeBanner: false,
        initialRoute: '/loginpage',
        routes: {
          '/loginpage': (context) => LoginPage(),
         '/signuppage': (context) => Signuppage(),
          '/home': (context) => HomePage(),
          '/forget1': (context) => ForgotPasswordPage(),
          '/forget2': (context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map;
  return ResetPasswordPage(code: args['code'], email: args['email']);
},
'/forget3': (context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map;
  return VerificationPage(email: args['email']);
},

          '/caseform': (context) => CaseFormPage(),
       //    '/volunteerform': (context) => VolunteerProfileFormPage(data: {},),
       //   '/volunteerdetail': (context) => VolunteerProfileDetailsPage(data: {},),
        },

      
      ),
    );
  }
}