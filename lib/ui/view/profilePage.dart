import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/VolunteerProfileDetailsPage.dart';
import 'package:hello/ui/view/about_page.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/ui/view/profileEditPage.dart';
import 'package:hello/ui/view/wallet_page.dart';
import 'package:hello/widgets/NavBar.dart';
import 'package:hello/ui/view/volunteer_profile_form_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
  
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, String>? volunteerData;
  Map<String, String>? walletData;
  int _currentTabIndex = 0;

  void createDummyWallet() {
    setState(() {
      walletData = {
        'amount': '3,000',
        'createdAt': '2025-08-01',
        'walletId': '#WLT123456',
      };
    });
  }

  void createDummyFile() {
    setState(() {
      volunteerData = {'name': 'يزن أبو العيال', 'date': '20-07-2025'};
    });
  }

  Future<Map<String, String>> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name') ?? 'غير محدد',
      'age': prefs.getString('age') ?? 'غير محدد',
      'gender': prefs.getString('gender') ?? 'غير محدد',
      'phone': prefs.getString('phone') ?? 'غير محدد',
      'city': prefs.getString('city') ?? 'غير محدد',
      'email': prefs.getString('email') ?? 'example@gmail.com',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 1, onTap: (index) {}),

      body: DefaultTabController(
        length: 4,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController = DefaultTabController.of(
              context,
            );
            tabController.addListener(() {
              setState(() {
                _currentTabIndex = tabController.index;
              });
            });
            return Scaffold(
              backgroundColor: medium_Green,

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
                                fontSize: 20,
                                color: Color(0XFFF2F4EC),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Zain',
                              ),
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
                    ),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, -30),
                          ),
                        ],
                        color: white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: white,
                            backgroundImage: AssetImage(
                              'assets/images/slider1.jpg',
                            ),
                          ),
                          Text(
                            "اسم المستخدم",
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
                                "نقطة",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: medium_Green,
                                   fontFamily: 'Zain',
                                ),
                              ),
                              Text(
                                "300",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 247, 119, 134),
                                  fontWeight: FontWeight.bold,
                                   fontFamily: 'Zain',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: TabBar(
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(color: zeti, width: 3),
                              ),
                              labelColor: zeti,
                              unselectedLabelColor: medium_Green,
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.file_copy),
                                  text: "ملف التطوع",
                                ),
                                Tab(
                                  icon: Icon(Icons.emoji_events),
                                  text: "إنجازاتي",
                                ),
                                Tab(icon: Icon(Icons.info), text: "معلوماتي"),
                                Tab(
                                  icon: Icon(Icons.account_balance_wallet),
                                  text: "محفظتي",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: TabBarView(
                              children: [
                                buildVolunteerTab(
                                  context,
                                  volunteerData,
                                  createDummyFile,
                                ),
                                buildAchievementsTab(context),
                                buildMyInfoTab(),
                                buildWalletTab(
                                  context,
                                  walletData,
                                  createDummyWallet,
                                ), // محفظتي
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton:
                  _currentTabIndex ==
                          2 // يظهر فقط في تاب معلوماتي
                      ? FloatingActionButton(
                        backgroundColor: medium_Green,
                        child: Icon(Icons.edit, color: white),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileEditPage(),
                            ),
                          );
                          setState(
                            () {},
                          ); // يعيد بناء الواجهة وتحميل البيانات الجديدة
                        },
                      )
                      : null,
            );
          },
        ),
      ),
    );
  }
}

Widget buildWalletTab(
  BuildContext context,
  Map<String, String>? walletData,
  VoidCallback onCreateWallet,
) {
  if (walletData == null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 60,
            color: medium_Green,
          ),
          SizedBox(height: 16),
          Text(
            'لم تقم بإنشاء محفظتك بعد',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
               fontFamily: 'Zain',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'اضغط أدناه لإنشاء محفظة إلكترونية واكتشف مزاياها',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 14 ,  fontFamily: 'Zain',),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: medium_Green,
              foregroundColor: Colors.white,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: Icon(Icons.add_circle_outline),
            label: Text("إنشاء محفظة"),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateWalletPage()),
              );
              if (result == true) {
                onCreateWallet(); // ✅ يستدعي setState من الأعلى
                DefaultTabController.of(context)?.animateTo(3);
              }
            },
          ),
        ],
      ),
    );
  } else {
    // ✅ شكل المحفظة الجميل
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                dark_Green, // أخضر غامق
                Light_Green, // أخضر فاتح
              ],
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
                ],
              ),
              SizedBox(height: 24),
              Text(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,

                '${walletData['amount']} ل.س',
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
                    style: TextStyle(color: Colors.white54, fontSize: 12 ,  fontFamily: 'Zain',),
                  ),
                  Text(
                    walletData['createdAt'] ?? 'غير معروف',
                    style: TextStyle(color: Colors.white, fontSize: 14 ,  fontFamily: 'Zain',),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildWalletInfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value, style: TextStyle(color: Colors.white, fontSize: 16)),
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 16)),
      ],
    ),
  );
}

Widget buildVolunteerTab(
  BuildContext context,
  Map<String, String>? data,
  VoidCallback onCreateFile,
) {
  if (data == null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ليس لديك ملف تطوع بعد، بادر بإنشاء ملفك الآن',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 16 ,  fontFamily: 'Zain',),
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
                  builder: (context) => VolunteerProfileFormPage(),
                ),
              );

              if (result != null) {
                print('Received profile data: $result');
                // مثلا:
                String skills = result['skills'];
                String availability = result['availability'];
                // وهكذا
              }
            },
          ),
        ],
      ),
    );
  } else {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VolunteerProfileDetailsPage(data: data),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: medium_Green.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // ✅ شريط أخضر جميل
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

                    // ✅ المعلومات (الاسم + التاريخ)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // ✅ أيقونة صغيرة
                              const Icon(
                                Icons.volunteer_activism,
                                color: Colors.black54,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  data['name'] ?? '',
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
                            'تاريخ التطوع: ${data['date'] ?? ''}',
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
            const SizedBox(height: 16),
            // يمكنك إضافة عناصر أخرى لاحقًا هنا
          ],
        ),
      ),
    );
  }
}

Widget buildMyInfoTab() {
  return FutureBuilder(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      }
      final prefs = snapshot.data as SharedPreferences;
      final name = prefs.getString('name') ?? 'غير محدد';
      final city = prefs.getString('city') ?? 'غير محدد';
      final phone = prefs.getString('phone') ?? 'غير محدد';
      final age = prefs.getString('age') ?? 'غير محدد';
      final gender = prefs.getString('gender') ?? 'غير محدد';
      final email =
          prefs.getString('email') ??
          'غير محدد'; // إذا أردت إضافة البريد لاحقًا

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildInfoCard(Icons.person, "اسم المستخدم", name),
              buildInfoCard(Icons.location_on, "المدينة", city),
              buildInfoCard(Icons.phone, " الرقم", phone),
              buildInfoCard(Icons.cake, "العمر", age),
              buildInfoCard(Icons.male, "الجنس", gender),
              buildInfoCard(Icons.email, "البريد الإلكتروني", email),
            ],
          ),
        ),
      );
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
        style: TextStyle(fontWeight: FontWeight.bold, color: zeti ,  fontFamily: 'Zain',),
      ),
      subtitle: Text(value, style: TextStyle(color: zeti ,  fontFamily: 'Zain',)),
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
  // ✅ متغير الحالة للتحكم في الفلترة
  String activeFilter =
      'الحملات الأكثر تأثيراً'; // يمكن نقله إلى State لو أردت جعله ديناميكي مع setState

  // قائمة إنجازات وهمية مؤقتًا (لاحقًا تربطها بالبيانات من SharedPreferences أو API)
  final achievements = [
    {'type': 'تطوع', 'title': 'مساعدة كبار السن', 'date': '2025-07-15'},
    {'type': 'تبرع', 'title': 'تبرع لمشروع سقيا الماء', 'date': '2025-07-10'},
    {'type': 'تطوع', 'title': 'تنظيف الحدائق', 'date': '2025-07-05'},
  ];

  return StatefulBuilder(
    builder: (context, setState) {
      // تصفية القائمة حسب الفلتر
      final filtered =
          activeFilter == 'الحملات الأكثر تأثيرا'
              ? achievements.where((a) => a['type'] == 'تبرع').toList()
              : achievements.where((a) => a['type'] == activeFilter).toList();

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ✅ شريط ملخص الإنجازات
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
                              '25',
                              style: TextStyle(
                                color: Color.fromARGB(255, 247, 119, 134),
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
                              '120',
                              style: TextStyle(
                                color: Color.fromARGB(255, 247, 119, 134),
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
                              '5,450 ريال',
                              style: TextStyle(
                                color: Color.fromARGB(255, 247, 119, 134),
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
              // ✅ أزرار التصفية
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
              // ✅ قائمة الإنجازات
              Column(
                children:
                    filtered.map((achievement) {
                      final isVolunteer = achievement['type'] == 'تطوع';
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Icon(
                            isVolunteer
                                ? Icons.volunteer_activism
                                : Icons.attach_money,
                            color: isVolunteer ? medium_Green : Colors.amber,
                          ),
                          title: Text(achievement['title']!),
                          subtitle: Text('التاريخ: ${achievement['date']}'),
                          trailing: Text(
                            achievement['type']!,
                            style: TextStyle(color: zeti ,  fontFamily: 'Zain',),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
