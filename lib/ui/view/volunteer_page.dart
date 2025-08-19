import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/ui/view/volunteerCompaign_detail_oage.dart';
import 'package:hello/widgets/elevatedButton.dart';

class VolunteerCampaignsPage extends StatelessWidget {
final List<Map<String, dynamic>> scheduledCampaigns = [
  {
    'title': 'حملة نظافة الشاطئ',
    'taskName': 'جمع النفايات',
    'status': 'مقبولة',
    'startDate': '2025-08-01',
    'startTime': '08:00',
    'endDate': '2025-08-05',
  },
  {
    'title': 'حملة زراعة الأشجار',
    'taskName': 'زرع الأشجار في الحديقة',
    'status': 'مقبولة',
    'startDate': '2025-08-10',
    'startTime': '09:00',
    'endDate': '2025-08-15',
  },
];


  final List<Map<String, dynamic>> campaigns = [
    {
      'image': 'assets/images/slider1.jpg',
      'title': 'حملة نظافة الشاطئ',
      'status': 'نشطة',
      'category': 'بيئي',
      'tasksCount': '3',
      'description': 'تنظيف الشاطئ من النفايات البلاستيكية',
      'startDate': '2025-08-01',
      'endDate': '2025-08-05',
      'location': 'طرطوس - شاطئ القرم',
      'startTime': '08:00',
      'endTime': '12:00',
      'tasks': [
        {
          'name': 'جمع النفايات',
          'vacancies': 5,
          'description': 'جمع النفايات البلاستيكية والعضوية',
        },
        {
          'name': 'تنظيم المتطوعين',
          'vacancies': 2,
          'description': 'توزيع المهام على الفرق',
        },
      ],
    },
  ];
  // final List<Map<String, dynamic>> scheduledCampaigns = [
  //   // يمكنك نسخ بعض الحملات من allCampaigns وتعديل الحقول حسب الحاجة
  //   {
  //     'title': 'حملة نظافة الشاطئ',
  //     'status': 'بانتظار القبول',
  //     'startDate': '2025-08-01',
  //     'startTime': '08:00',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFF4B4D40),
                    const Color.fromARGB(255, 115, 123, 114),
                    const Color(0xFFb3beb0),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              alignment: Alignment.center,
              child: Image.asset('assets/images/logo2.png', height: 60, width: 60),
            ),

            Positioned(
              top: 20,
              right: 16,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0X80D9E4D7).withAlpha(85),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0XFFF2F4EC)),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0XFFF2F4EC),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            Positioned(
              top: 20,
              left: 16,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0X80D9E4D7).withAlpha(85),
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: const Color(0XFFF2F4EC)),
                ),
                child: const Text(
                  ' قسم التطوع',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0XFFF2F4EC),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Zain',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFFF2F4EC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TabBar(
                          indicatorColor: medium_Green,
                          labelColor: zeti,
                          unselectedLabelColor: Light_Green,
                          tabs: [
                            Tab(text: 'كل الحملات'),
                            Tab(text: 'جدولة المهام'),
                          ],
                        ),
                      ),

                      Expanded(
                        child: TabBarView(
                          children: [
                            buildCampaignsList(context, campaigns),
                            buildScheduledList(context, scheduledCampaigns),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55),
                topRight: Radius.circular(55),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCampaignsList(
    BuildContext context,
    List<Map<String, dynamic>> campaigns,
  ) {
    return Container(
      color: const Color(0XFFF2F4EC),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final c = campaigns[index];
          return buildVolunteerCampaignCard(
            imageUrl: c['image'],
            title: c['title'],
            status: c['status'],
            category: c['category'],
            tasksCount: c['tasksCount'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsAssociationcamps(),
                ),
              );
            },
          );
        },
      ),
    );
  }
// Widget buildScheduledList(
//   BuildContext context,
//   List<Map<String, dynamic>> campaigns,
// ) {
//   final acceptedCampaigns = campaigns.where((c) => c['status'] == 'مقبولة').toList();

//   acceptedCampaigns.sort((a, b) {
//     final aDate = DateTime.parse('${a['startDate']} ${a['startTime']}');
//     final bDate = DateTime.parse('${b['startDate']} ${b['startTime']}');
//     return aDate.compareTo(bDate);
//   });

//   return ListView.builder(
//     padding: const EdgeInsets.all(20),
//     itemCount: acceptedCampaigns.length,
//     itemBuilder: (context, index) {
//       final campaign = acceptedCampaigns[index];

//       String currentStatus = campaign['status'] ?? 'مقبولة';

//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             child: ListTile(
//               title: Text(campaign['title'] ?? ''),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('المهمة: ${campaign['taskName'] ?? ''}'),
//                   Text('تاريخ الانتهاء: ${campaign['endDate'] ?? ''}'),
//                 ],
//               ),
//               trailing: DropdownButton<String>(
//                 value: currentStatus,
//                 items: <String>['مقبولة', 'تم الاعتذار'].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (String? newStatus) {
//                   if (newStatus != null) {
//                     setState(() {
//                       currentStatus = newStatus;
//                       campaign['status'] = newStatus; // لتحديث الحالة في القائمة
//                     });
//                   }
//                 },
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
Widget buildScheduledList(
  BuildContext context,
  List<Map<String, dynamic>> campaigns,
) {
  final List<Map<String, dynamic>> fakeTasks = [
    {
      'title': 'حملة تنظيف الشاطئ',
      'taskName': 'جمع النفايات البلاستيكية',
      'status': 'مقبولة',
      'endDate': '2025-08-05',
    },
    {
      'title': 'حملة زراعة الأشجار',
      'taskName': 'زرع الأشجار في الحديقة العامة',
      'status': 'مقبولة',
      'endDate': '2025-08-10',
    },
  ];

  return ListView.builder(
    padding: const EdgeInsets.all(30),
    itemCount: fakeTasks.length,
    itemBuilder: (context, index) {
      final task = fakeTasks[index];
      String currentStatus = task['status'] ?? 'مقبولة';

      return StatefulBuilder(
        builder: (context, setState) {
          return Card(
            color: babygreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 6,
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                       textDirection: TextDirection.rtl,
                    task['title'] ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: zeti,
                       fontFamily: 'Zain',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
             textDirection: TextDirection.rtl,

                  
                    'المهمة: ${task['taskName'] ?? ''}',
                    style: TextStyle(
                      fontSize: 16,
                      color: medium_Green,
                       fontFamily: 'Zain',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                                           textDirection: TextDirection.rtl,

                    'تاريخ الانتهاء: ${task['endDate'] ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      color:  Color.fromARGB(255, 247, 119, 134),
                       fontFamily: 'Zain',
                    ),
                  ),
                  SizedBox(height: 16),

                  DropdownButton<String>(
                    value: currentStatus,
                    items: ['مقبولة', 'انسحاب'].map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(
                          status,
                          style: TextStyle(
                            color: status == 'انسحاب' ?  Color.fromARGB(255, 247, 119, 134) : dark_Green,
                             fontFamily: 'Zain',
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newStatus) {
                      if (newStatus != null) {
                        setState(() {
                          currentStatus = newStatus;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

  Widget buildVolunteerCampaignCard({
    required String imageUrl,
    required String title,
    required String status,
    required String category,
    required String tasksCount,
    required VoidCallback onTap,
  }) {
    bool isActive = status == 'نشطة';

    return InkWell(
      onTap: onTap, // ✨ هون حطينا الإجراء

      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.15),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.rtl,

              children: [
                //  صورة الحملة
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imageUrl,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: 12),

                //  نصوص يسار الصورة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: zeti,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 6),

                      // ✅ التصنيف والحالة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ✅ الحالة (يسار السطر)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isActive
                                      ? dark_Green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color:
                                    isActive
                                        ? dark_Green
                                        : Color.fromARGB(255, 247, 119, 134),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),

                          // ✅ التصنيف (يمين السطر مع الأيقونة)
                          Row(
                            children: [
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: dark_Green,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.category_outlined,
                                size: 18,
                                color: dark_Green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),
            Divider(color: Colors.grey[300]),

            //  عدد المهام
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$tasksCount مهام',
                  style: TextStyle(
                    color: dark_Green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.checklist_rounded,
                  size: 18,
                  color: Color.fromARGB(255, 247, 119, 134),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
