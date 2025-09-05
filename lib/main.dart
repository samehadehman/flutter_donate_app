import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/Cities/cities_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_bloc.dart';
import 'package:hello/blocs/profile/mini_bloc.dart';
import 'package:hello/blocs/profile/mini_event.dart';
import 'package:hello/blocs/userinfo/userinfo_bloc.dart';
import 'package:hello/blocs/userinfo/userinfo_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerprodetail_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerprodetail_event.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_bloc.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_event.dart';
import 'package:hello/blocs/voluntingCamp/task_bloc.dart';
import 'package:hello/blocs/wallet/wallet_bloc.dart';
import 'package:hello/blocs/wallet/wallet_event.dart';
import 'package:hello/services/cities_service.dart';
import 'package:hello/services/userInfo_service.dart';
import 'package:hello/services/userProfile_service.dart';
import 'package:hello/services/volunteerProfileForm_service.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:hello/services/wallet_service.dart';
import 'package:hello/ui/view/case_form_page.dart';
import 'package:hello/ui/view/forget_pass.dart';
import 'package:hello/ui/view/reset_pass.dart';
import 'package:hello/ui/view/verification.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/ui/view/loginpage.dart';
import 'package:hello/ui/view/signuppage.dart';
import 'package:hello/ui/view/volunteerCompaign_detail_oage.dart';
import 'package:hello/ui/view/volunteer_page.dart';
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
    VolunteerService(),
    // UserService(dio: dio),
  )..add(GetVolunteerProfileEvent()), // ✅ هاد السطر بجيب الملف من السيرفر أول ما يشتغل
),

// BlocProvider(
//   create: (_) => VolunteerProfileDetailBloc(VolunteerService(dio))
//     ..add(FetchVolunteerDetailProfile()), // ✅ أول ما يشتغل يجيب الداتا
// ),
BlocProvider(
          create: (context) => CityBloc(service: CityService()),
        ),
        BlocProvider<UserInfoBloc>(
          create: (_) => UserInfoBloc(UserInfoService())..add(FetchUserInfo()),
        ),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(service: UserService())..add(LoadUser()),
        ),

        BlocProvider(
      create: (_) => WalletBloc(WalletService())..add(FetchWallet()),),

      // BlocProvider(
      //   create: (context) => ScheduledTasksBloc(CampaignService())..add(FetchScheduledTasks()),
      //   child: VolunteerCampaignsPage(),
      // ),
      BlocProvider(
      create: (context) => TaskBloc(CampaignService()), // ضفنا التابع المسؤول عن UpdateTaskStatus
    ),
    
      ],

      child: MaterialApp(
    
        debugShowCheckedModeBanner: false,
//         initialRoute: '/loginpage',
       routes: {
//           '/loginpage': (context) => LoginPage(),
//          '/signuppage': (context) => Signuppage(),
//           '/home': (context) => HomePage(),
//           '/forget1': (context) => ForgotPasswordPage(),
//           '/forget2': (context) {
//   final args = ModalRoute.of(context)!.settings.arguments as Map;
//   return ResetPasswordPage(code: args['code'], email: args['email']);
// },
// '/forget3': (context) {
//   final args = ModalRoute.of(context)!.settings.arguments as Map;
//   return VerificationPage(email: args['email']);
// },
 
//           '/caseform': (context) => CaseFormPage(),
//        //    '/volunteerform': (context) => VolunteerProfileFormPage(data: {},),
//        //   '/volunteerdetail': (context) => VolunteerProfileDetailsPage(data: {},),
//         },


          Signuppage.id: (context) => Signuppage(),
          LoginPage.id: (context) => LoginPage(),
          HomePage.id: (context) => HomePage(),
    ForgotPasswordPage.id: (context) => ForgotPasswordPage(),
 ResetPasswordPage.id: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      return ResetPasswordPage(
        code: args['code'],
        email: args['email'],
      );
    },
    VerificationPage.id: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      return VerificationPage(
        email: args['email'],
      );
    },
    VolunteerCampaignsPage.id: (context)=> VolunteerCampaignsPage(),
DetailsAssociationcamps.id: (context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map;
  return DetailsAssociationcamps(campaignId: args['campaignId']);
},
       },
    home: HomePage(),
      ),

      
    );
  }
}