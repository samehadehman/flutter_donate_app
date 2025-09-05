import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/achievement/achievement_bloc.dart';
import 'package:hello/blocs/achievement/achievement_event.dart';
import 'package:hello/blocs/achievement/achievement_state.dart';
import 'package:hello/blocs/achievement/mostDonationFor_bloc.dart';
import 'package:hello/blocs/achievement/mostDonationFor_event.dart';
import 'package:hello/blocs/achievement/mostDonationFor_state.dart';
import 'package:hello/blocs/achievement/mydonation_bloc.dart';
import 'package:hello/blocs/achievement/mydonation_event.dart';
import 'package:hello/blocs/achievement/mydonation_state.dart';
import 'package:hello/blocs/achievement/myvolounting_bloc.dart';
import 'package:hello/blocs/achievement/myvolounting_event.dart';
import 'package:hello/blocs/achievement/myvolounting_state.dart';
import 'package:hello/blocs/auth/auth_bloc.dart';
import 'package:hello/blocs/profile/mini_bloc.dart';
import 'package:hello/blocs/profile/mini_state.dart';
import 'package:hello/blocs/userinfo/userinfo_bloc.dart';
import 'package:hello/blocs/userinfo/userinfo_event.dart';
import 'package:hello/blocs/userinfo/userinfo_state.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_state.dart';
import 'package:hello/blocs/wallet/wallet_bloc.dart';
import 'package:hello/blocs/wallet/wallet_event.dart';
import 'package:hello/core/color.dart';
import 'package:hello/models/achievementSummary.dart';
import 'package:hello/services/achievementService.dart';
import 'package:hello/services/mostDonationFor_service.dart';
import 'package:hello/services/mydonation_service.dart';
import 'package:hello/services/myvolounting_service.dart';
import 'package:hello/ui/view/VolunteerProfileDetailsPage.dart';
import 'package:hello/ui/view/profileEditPage.dart';
import 'package:hello/ui/view/signuppage.dart';
import 'package:hello/ui/view/wallet_page.dart';
import 'package:hello/widgets/NavBar.dart';
import 'package:hello/ui/view/volunteer_profile_form_page.dart';
import 'package:hello/widgets/elevatedButton.dart';

class ProfilePage extends StatefulWidget {
  
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, String>? walletData;
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => Signuppage()),
);
        } else if (state is AuthFailure) {
                print("🔴 فشل تسجيل الخروج: ${state.error}");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0XFF4B4D40),
            Color.fromARGB(255, 115, 123, 114),
            Color(0xFFb3beb0),
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavBar(currentIndex: 1, onTap: (index) {}),
        body: DefaultTabController(
          length: 4,
          child: Builder(
            builder: (context) {
              final tabController = DefaultTabController.of(context)!;
              tabController.addListener(() {
                setState(() {
                  _currentTabIndex = tabController.index;
                });
              });
              return Scaffold(
                          backgroundColor:  Color.fromARGB(255, 115, 123, 114),
                floatingActionButton:
                    _currentTabIndex == 2
                        ? FloatingActionButton(
                          backgroundColor: zeti,
                          child: Icon(Icons.edit, color: white),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileEditPage(),
                              ),
                            );
                            // تحديث البيانات بعد الرجوع
                            context.read<UserInfoBloc>().add(FetchUserInfo());
                          },
                        )
                        : null,
                body: Column(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0X80D9E4D7).withAlpha(85),
                                borderRadius: BorderRadius.circular(90),
                                border: Border.all(color: Color(0XFFF2F4EC)),
                              ),
                              child: const Text(
                                ' الملف الشخصي',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0XFFF2F4EC),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Zain',
                                ),
                              ),
                            ),
                            Row(
      children: [
        // زر الخروج
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: const Color(0X80D9E4D7).withAlpha(85),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Color(0XFFF2F4EC)),
          ),
          child: IconButton(
            icon: Icon(Icons.logout, color: Color(0XFFF2F4EC)),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
        backgroundColor: Color(0XFFF2F4EC),
                          content: Text("هل أنت متأكد أنك تريد تسجيل الخروج؟" ,
                   textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 115, 123, 114),
            fontWeight: FontWeight.w600,
            fontFamily: 'Zain',
          ),
        ),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,

                  actions: [
                    TextButton(
         style: TextButton.styleFrom(foregroundColor: zeti),

                      onPressed: () => Navigator.pop(ctx, false),
                      child: Text("إلغاء" , style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 247, 119, 134),
                fontWeight: FontWeight.w600,
                fontFamily: 'Zain',
              ),
            ),
          ),
                   ElevatedButtonWidget(
            textElevated: 'تأكيد',
            height: 35,
            width: 70,
            onPressed: () { Navigator.pop(ctx, true);
            }
              ),
            
                    
            
                  ],
                ),
              );
    print("🔹 نتيجة تأكيد الخروج: $confirm");

              if (confirm == true) {
                      print("🔹 أرسل الحدث LogoutRequested للـ AuthBloc");

      context.read<AuthBloc>().add(LogoutRequested());
              }
            },
          ),
        ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0X80D9E4D7).withAlpha(85),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Color(0XFFF2F4EC)),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0XFFF2F4EC),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
                 const   SizedBox(height: 40),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 252, 248, 241),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                          ),
                        ),
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is UserLoaded) {
                              final user = state.user;
                              return Column(
                                children: [
                                  SizedBox(height: 16),
                                  CircleAvatar(
                                    radius: 55,
                                    //Color.fromARGB(255, 252, 248, 241)
                                    backgroundColor: const Color.fromARGB(255, 252, 248, 241),
                                    backgroundImage: NetworkImage(
                                      user.avatarUrl,
                                    ),
                                  ),
                                  Text(
                                    user.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: zeti,
                                      fontFamily: 'Zain',
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "نقطة ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: medium_Green,
                                          fontFamily: 'Zain',
                                        ),
                                      ),
                                      Text(
                                        "${user.points}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                            255,
                                            247,
                                            119,
                                            134,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Zain',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                    ),
                                    child: TabBar(
                                      indicator: UnderlineTabIndicator(
                                        borderSide: BorderSide(
                                          color: zeti,
                                          width: 3,
                                        ),
                                      ),
                                      labelColor: zeti,
                                      unselectedLabelColor:Color.fromARGB(255, 115, 123, 114),

                                      tabs: [
                                        Tab(
                                          icon: Icon(Icons.file_copy),
                                          text: "ملف التطوع",
                                        ),
                                        Tab(
                                          icon: Icon(Icons.emoji_events),
                                          text: "إنجازاتي",
                                        ),
                                        Tab(
                                          icon: Icon(Icons.info),
                                          text: "معلوماتي",
                                        ),
                                        Tab(
                                          icon: Icon(
                                            Icons.account_balance_wallet,
                                          ),
                                          text: "محفظتي",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        buildVolunteerTab(context),

                                        buildAchievementsTab(context),
                                        buildMyInfoTab(context),
                                        buildWalletTab(context),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else if (state is UserError) {
                              return Center(child: Text(state.message));
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ),
                ],
                ),
              );
            },
          ),
        ),
      ),
      )
    );
  }
}

Widget buildVolunteerTab(BuildContext context) {
  return BlocBuilder<VolunteerProfileBloc, VolunteerProfileState>(
    builder: (context, state) {
      if (state is VolunteerProfileViewSuccess) {
        final data = state.profile; // VolunteerProfileView

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
             
                  onTap: () {
                    context.read<VolunteerProfileBloc>().add(
                      GetVolunteerDetailProfileEvent(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => VolunteerProfileDetailsPage(), // بدون data
                      ),
                    ).then((_) {
                      // ⚡️ بعد الرجوع من صفحة التفاصيل، نعيد تحميل الملف لعرض الكارد
                      context.read<VolunteerProfileBloc>().add(
                        GetVolunteerProfileEvent(),
                      );
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: zeti.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                medium_Green.withOpacity(0.8),
                                medium_Green.withOpacity(0.4),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.volunteer_activism,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      data.volunteerName,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontFamily: 'Zain',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'تاريخ التطوع: ${data.timeBecomingVolunteerMember}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontFamily: 'Zain',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is VolunteerProfileInitial ||
          state is VolunteerProfileError) {
        // 👇 إذا ما في ملف نعرض زر إنشاء
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ليس لديك ملف تطوع بعد، بادر بإنشاء ملفك الآن',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontFamily: 'Zain',
                ),
              ),
              const SizedBox(height: 12),
              IconButton(
                icon: const Icon(
                  Icons.drive_file_move,
                  size: 32,
                  color: Colors.black54,
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VolunteerProfileFormPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      } else if (state is VolunteerProfileLoading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}

Widget buildWalletTab(BuildContext context) {
  return BlocBuilder<WalletBloc, WalletState>(
    builder: (context, state) {
      if (state is WalletLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is WalletLoaded) {
        return buildWalletContent(
          context,
          amount: state.wallet.walletValue.toString(),
          createdAt: state.wallet.createdAt.toIso8601String().split('T')[0],
        );
      } else if (state is WalletEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 60,
                color: zeti,
              ),
              SizedBox(height: 16),
              Text(
                'لم تقم بإنشاء محفظتك بعد',
                style: TextStyle(
                  fontSize: 18,
                  color: zeti,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Zain',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'اضغط أدناه لإنشاء محفظة إلكترونية واكتشف مزاياها',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: medium_Green,
                  fontSize: 14,
                  fontFamily: 'Zain',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Light_Green,
                  foregroundColor: Colors.white,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: Icon(Icons.add_circle_outline),
                label: Text("إنشاء محفظة"),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider.value(
                            value: context.read<WalletBloc>(),
                            child: CreateWalletPage(),
                          ),
                    ),
                  );
                  context.read<WalletBloc>().add(FetchWallet());
                },
              ),
            ],
          ),
        );
      } else if (state is WalletError) {
        return Center(child: Text(state.message));
      } else {
        return SizedBox();
      }
    },
  );
}

Widget buildWalletContent(
  BuildContext context, {
  required String amount,
  required String createdAt,
}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [dark_Green, Light_Green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: zeti.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                Spacer(),
                Text(
                  'محفظة الكترونية',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                    fontFamily: 'Zain',
                  ),
                ),
                SizedBox(width: 8),
                // أيقونة التعديل
                InkWell(
                  onTap: () async {
                    // فتح صفحة تعديل/إنشاء المحفظة
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BlocProvider.value(
                              value: context.read<WalletBloc>(),
                              child: CreateWalletPage(
                                isEdit: true,
                                currentAmount: amount,
                              ),
                            ),
                      ),
                    );
                    // بعد الرجوع، جلب أحدث بيانات
                    context.read<WalletBloc>().add(FetchWallet());
                  },
                  child: Icon(Icons.edit, color: Colors.white, size: 22),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              '$amount ل.س',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontFamily: 'Zain',
              ),
            ),
            SizedBox(height: 38),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تاريخ الإنشاء',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontFamily: 'Zain',
                  ),
                ),
                Text(
                  createdAt,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Zain',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildMyInfoTab(BuildContext context) {
  return BlocBuilder<UserInfoBloc, UserInfoState>(
    builder: (context, state) {
      if (state is UserInfoLoading || state is UserInfoUpdating) {
        return Center(child: CircularProgressIndicator());
      } else if (state is UserInfoLoaded) {
        final user = state.userInfo;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildInfoCard(
                  Icons.person,
                  "اسم المستخدم",
                  user.userName ?? "غير محدد",
                ),
                buildInfoCard(Icons.cake, "العمر", user.age ?? "غير محدد"),
                buildInfoCard(
                  user.gender == "أنثى" ? Icons.female : Icons.male,
                  "الجنس",
                  user.gender ?? "غير محدد",
                ),
                buildInfoCard(Icons.phone, "الرقم", user.phone ?? "غير محدد"),

                buildInfoCard(
                  Icons.location_on,
                  "المدينة",
                  user.cityName ?? "غير محدد",
                ),

                buildInfoCard(
                  Icons.email,
                  "البريد الإلكتروني",
                  user.email ?? "غير محدد",
                ),
              ],
            ),
          ),
        );
      } else if (state is UserInfoError) {
        return Center(child: Text("خطأ: ${state.message}"));
      }
      return Center(child: Text("اضغط تحديث لجلب البيانات"));
    },
  );
}

Widget buildInfoCard(IconData icon, String title, String value) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      leading: Icon(icon, color: medium_Green),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: zeti,
          fontFamily: 'Zain',
        ),
      ),
      subtitle: Text(value, style: TextStyle(color: zeti, fontFamily: 'Zain')),
    ),
  );
}

Widget buildEmptyMessage(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
          height: 1.6,
          fontFamily: 'Zain',
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget buildAchievementsTab(BuildContext context) {
  String activeFilter = 'الحملات الأكثر تأثيرا';

  return StatefulBuilder(
    builder: (context, setState) {
      return BlocProvider(
        create:
            (_) =>
                AchievementBloc(AchievementService())..add(LoadAchievement()),
        child: BlocBuilder<AchievementBloc, AchievementState>(
          builder: (context, state) {
            AchievementSummary? summary;

            if (state is AchievementLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AchievementLoaded) {
              summary = state.summary;
            } else if (state is AchievementError) {
              return Center(child: Text(state.message));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ✅ ملخص الإنجازات
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: medium_Green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'ملخص إنجازاتك',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: zeti,
                            fontFamily: 'Zain',
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${summary?.totalCampaigns ?? 0}',
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Zain',
                                  ),
                                ),
                                Text('الحملات'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${summary?.totalVolunteeringHours ?? 0}',
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Zain',
                                  ),
                                ),
                                Text('ساعات التطوع'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${summary?.totalDonations ?? 0} ريال',
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Zain',
                                  ),
                                ),
                                Text('التبرعات'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // ✅ أزرار الفلترة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        ['الحملات الأكثر تأثيرا', 'تطوع', 'تبرع'].map((filter) {
                          final isActive = activeFilter == filter;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isActive ? medium_Green : Colors.grey[200],
                                foregroundColor:
                                    isActive ? Colors.white : Colors.black,
                                shape: StadiumBorder(),
                              ),
                              onPressed:
                                  () => setState(() => activeFilter = filter),
                              child: Text(filter),
                            ),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 16),

                  // ✅ محتوى حسب الفلتر
                  if (activeFilter == 'تبرع')
                    BlocProvider(
                      create:
                          (_) => DonationBloc(
                            donationService: MyDonationService(),
                          )..add(LoadDonations()),
                      child: BlocBuilder<DonationBloc, DonationState>(
                        builder: (context, donationState) {
                          if (donationState is DonationLoading) {
                            return CircularProgressIndicator();
                          } else if (donationState is DonationLoaded) {
                            if (donationState.donations.isEmpty) {
                              return Text("لا يوجد تبرعات بعد");
                            }
                            return Column(
                              children:
                                  donationState.donations.map((donation) {
                                    return ListTile(
                                      leading: Icon(
                                        Icons.attach_money,
                                        color: Colors.amber,
                                      ),
                                      title: Text(donation.campaignName),
                                      subtitle: Text(
                                        "التاريخ: ${donation.donationTime}",
                                      ),
                                      trailing: Text(
                                        'تبرع',
                                        style: TextStyle(color: zeti),
                                      ),
                                    );
                                  }).toList(),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    )
                  else if (activeFilter == 'تطوع')
                    BlocProvider(
                      create:
                          (_) => VolunteerBloc(
                            volunteerService: MyVolunteerService(),
                          )..add(LoadVolunteers()),
                      child: BlocBuilder<VolunteerBloc, VolunteerState>(
                        builder: (context, volunteerState) {
                          if (volunteerState is VolunteerLoading) {
                            return CircularProgressIndicator();
                          } else if (volunteerState is VolunteerLoaded) {
                            if (volunteerState.volunteers.isEmpty) {
                              return Text("لا يوجد تطوعات بعد");
                            }
                            return Column(
                              children:
                                  volunteerState.volunteers.map((v) {
                                    return ListTile(
                                      leading: Icon(
                                        Icons.volunteer_activism,
                                        color: medium_Green,
                                      ),
                                      title: Text(v.campaignName),
                                      subtitle: Text(
                                        "التاريخ: ${v.volunteeringTime}",
                                      ),
                                      trailing: Text(
                                        'تطوع',
                                        style: TextStyle(color: zeti),
                                      ),
                                    );
                                  }).toList(),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    )
                  else if (activeFilter == 'الحملات الأكثر تأثيرا')
                    BlocProvider(
                      create:
                          (_) => ImpactCampaignBloc(
                            service: ImpactCampaignService(),
                          )..add(LoadImpactCampaigns()),
                      child:
                          BlocBuilder<ImpactCampaignBloc, ImpactCampaignState>(
                            builder: (context, impactState) {
                              if (impactState is ImpactCampaignLoading) {
                                return CircularProgressIndicator();
                              } else if (impactState is ImpactCampaignLoaded) {
                                if (impactState.campaigns.isEmpty) {
                                  return Text("لا يوجد حملات حالياً");
                                }
                                return Column(
                                  children:
                                      impactState.campaigns.map((c) {
                                        return ListTile(
                                          leading: Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                          ),
                                          title: Text(c.campaignName),
                                          subtitle: Text(
                                            "مؤشر التأثير: ${c.impactScore}",
                                          ),
                                          trailing: Text(
                                            'حملة',
                                            style: TextStyle(color: zeti),
                                          ),
                                        );
                                      }).toList(),
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                    ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
