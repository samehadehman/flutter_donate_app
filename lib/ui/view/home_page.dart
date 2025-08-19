import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hello/core/color.dart';
import 'package:hello/models/emergencyCase.dart';
import 'package:hello/ui/view/VolunteerProfileDetailsPage.dart';
import 'package:hello/ui/view/about_page.dart';
import 'package:hello/ui/view/profilePage.dart';
import 'package:hello/ui/view/volunteer_page.dart';
import 'package:hello/widgets/NavBar.dart';
import 'package:hello/widgets/QuickDonateButton.dart';
import 'package:hello/widgets/elevatedButton.dart';

// ========== Search Delegate ==========

class SimpleSearchDelegate extends SearchDelegate<String> {
  final List<String> searchItems = ['حملة 1', 'حملة 2', 'حملة 3', 'تبرع عيني'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: medium_Green),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: medium_Green),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: beig,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 60, color: Color(0xFFF2F4EC)),
            SizedBox(height: 20),
            Text(
              'نتيجة البحث: $query',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFFF2F4EC),
                fontWeight: FontWeight.bold,
                fontFamily: 'Zain',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        searchItems.where((item) => item.contains(query)).toList();

    return Container(
      color: white,
      child: ListView.separated(
        itemCount: suggestions.length,
        separatorBuilder:
            (context, index) =>
                Divider(color: medium_Green, indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final item = suggestions[index];
          return ListTile(
            leading: Icon(Icons.search, color: medium_Green),
            title: Text(
              item,
              style: TextStyle(
                fontSize: 14,
                color: medium_Green,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              query = item;
              showResults(context);
            },
          );
        },
      ),
    );
  }
}

// ========== Home Page ==========

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ValueNotifier<int> floatingStateNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavBar(currentIndex: 0, onTap: (index) {}),
        floatingActionButton: const GlobalDonationFab(),
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: babygreen,
                ),
                child: IconButton(
                  icon: Icon(Icons.search, color: medium_Green),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SimpleSearchDelegate(),
                    );
                  },
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تراحم',
                    style: TextStyle(
                      color: medium_Green,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                       fontFamily: 'Zain',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ===== Carousel Slider =====
              CarouselSlider(
                items: [
                  buildCarouselItem(
                    'assets/images/slider1.jpg',
                    'لَن تَنَالُوا الْبِرَّ حَتَّى تُنفِقُوا مِمَّا تُحِبُّونَ',
                  ),
                  buildCarouselItem(
                    'assets/images/slider1.jpg',
                    'وَمَا تُقَدِّمُوا لِأَنفُسِكُم مِّنْ خَيْرٍ تَجِدُوهُ عِندَ اللَّهِ',
                  ),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'الأقسام',
                style: TextStyle(
                  color: dark_Green,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                   fontFamily: 'Zain',
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sectionCard(
                      context,
                      'الحملات',
                      Icons.campaign,
                      DummyPage('الحملات'),
                    ),
                    sectionCard(
                      context,
                      'التبرع العيني',
                      Icons.volunteer_activism,
                      DummyPage('التبرع العيني'),
                    ),
                    sectionCard(
                      context,
                      'الكوارث',
                      Icons.warning,
                      DummyPage('الكوارث'),
                    ),
                    sectionCard(
                      context,
                      'قسم التطوع',
                      Icons.groups,
                      VolunteerCampaignsPage(),
                    ), // ✅ هنا صفحة التطوع الحقيقية
                  ],
                ),
              ),

              const SizedBox(height: 18),
              Text(
                'الحالات الطارئة',
                style: TextStyle(
                  color: dark_Green,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                   fontFamily: 'Zain',
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 350,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return buildEmergencyCard(
                      title: 'حملة كفالة أيتام',

                      imagePath: 'assets/images/slider1.jpg',
                      location: 'ريف دمشق',
                      money: 3500,
                      days: '${index + 5}',
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'الإحصائيات',
                style: TextStyle(
                  color: dark_Green,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                   fontFamily: 'Zain',
                ),
              ),
              const SizedBox(height: 12),

              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: buildStatBox('عدد المستفيدين', '2500')),
                      const SizedBox(width: 12),
                      Expanded(child: buildStatBox('عدد الجمعيات', '38')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: buildStatBox('إجمالي التبرعات', '1200')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: buildStatBox('عدد التبرعات العينية', '180'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('صفحة $title', style: TextStyle(fontSize: 30 ,  fontFamily: 'Zain',), )),
    );
  }
}

Widget buildCarouselItem(String imagePath, String text) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: zeti.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              // fontFamily: 'Zain',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}

Widget buildEmergencyCard({
  required String title,

  required String imagePath,
  required String location,
  required int money,
  required String days,
}) {
  return Stack(
    children: [
      Container(
        height: 360,
        width: 320,
        decoration: BoxDecoration(
          // border: Border.all(color: medium_Green,),
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: zeti.withOpacity(0.4),
              blurRadius: 6,
              offset: Offset(10, 1),
            ),
          ],
        ),
      ),
      Container(
        height: 350,
        width: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0XFFF2F4EC),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Zain',
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFFb3beb0), size: 16),
                    const SizedBox(width: 5),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0XFFF2F4EC),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Zain',
                      ),
                    ),
                    const SizedBox(width: 25),
                    Icon(Icons.money, color: Color(0xFFb3beb0), size: 16),
                    const SizedBox(width: 5),
                    Text(
                      money.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0XFFF2F4EC),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Zain',
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(150),
                    borderRadius: BorderRadius.circular(25),
                  ),

                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,

                      backgroundColor: Light_Green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    child: Text(
                      'تبرع',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w600,
                        color: zeti,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget sectionCard(
  BuildContext context,
  String title,
  IconData iconData,
  Widget targetPage,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        Material(
          color: babygreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: medium_Green),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            splashColor: white.withOpacity(0.3),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => targetPage),
              );
            },

            child: Container(
              width: 80,
              height: 80,
              child: Center(child: Icon(iconData, color: dark_Green, size: 30)),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            title,
            style: TextStyle(
              color: dark_Green,
              fontWeight: FontWeight.bold,
              fontSize: 14,
               fontFamily: 'Zain',
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget buildStatBox(String title, String value) {
  return Container(
    decoration: BoxDecoration(
      color: babygreen,
      borderRadius: BorderRadius.circular(20),
      
    ),
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: zeti,
            fontSize: 14,
            fontWeight: FontWeight.w500,
             fontFamily: 'Zain',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Color.fromARGB(255, 247, 119, 134),
            fontSize: 18,
            fontWeight: FontWeight.bold,
             fontFamily: 'Zain',
          ),
        ),
      ],
    ),
  );
}
