import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/widgets/NavBar.dart';

class NotificationsPage extends StatelessWidget {
  static const String id = "notifications";

  final List<Map<String, String>> notifications = const [
    {
      "title": "تمت الموافقة على طلبك",
      "body": "تهانينا! تم قبولك في حملة التبرع الخاصة بجمعية تراحم."
    },
    {
      "title": "حملة جديدة متاحة",
      "body": "يمكنك الآن الانضمام إلى حملة الشتاء لمساعدة المحتاجين."
    },
    {
      "title": "تذكير بالموعد",
      "body": "غدًا هو اليوم الأول لحملة جمع التبرعات، نرجو حضورك في الوقت المحدد."
    },
  ];

  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            bottomNavigationBar: BottomNavBar(currentIndex: 2, onTap: (index ) {  },),

      body: Stack(
        children: [
          // 🔹 الخلفية
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
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
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo2.png',
              height: 60,
              width: 60,
            ),
          ),

          // 🔹 زر الرجوع
          Positioned(
            top: 20,
            right: 16,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0X80D9E4D7).withAlpha(85),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: const Color(0XFFF2F4EC)),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios,
                    color: Color(0XFFF2F4EC)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // 🔹 العنوان
          Positioned(
            top: 20,
            left: 16,
            child: Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0X80D9E4D7).withAlpha(85),
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: const Color(0XFFF2F4EC)),
              ),
              child: const Text(
                'الإشعارات',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0XFFF2F4EC),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Zain',
                ),
              ),
            ),
          ),

          // 🔹 المحتوى الأبيض
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: babygreen.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -15),
                  ),
                ],
                border: Border(
                  top: BorderSide(color: zeti, width: 2),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
                ),
                color: const Color.fromARGB(255, 252, 248, 241),
              ),
              child: ListView.separated(
                padding:
                    const EdgeInsets.only(left: 16, right: 16, top: 70),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return buildNotificationCard(
                    context,
                    title: item["title"]!,
                    body: item["body"]!,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildNotificationCard(BuildContext context,
      {required String title, required String body}) {
    return Material(
      color: white,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: medium_Green.withOpacity(0.1),
              child:  Icon(Icons.notifications,
                  color: zeti, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: zeti,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Zain',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: TextStyle(
                      color: zeti,
                      fontSize: 13,
                      fontFamily: 'Zain',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}