import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/VolunteerProfileDetailsPage.dart';
import 'package:hello/ui/view/about_page.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/ui/view/profilePage.dart';


class BottomNavBar extends StatelessWidget {

   final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 252, 248, 241),
          currentIndex: currentIndex,
          selectedItemColor: zeti,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
             if (index == 0) {
   Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));    }
    else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => VolunteerProfileDetailsPage(data: {},)));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AboutPage()));
    }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف الشخصي'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'الإشعارات'),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'المزيد'),
          ],
        ),
      ),
    );
  }
}