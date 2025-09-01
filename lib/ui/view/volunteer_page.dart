import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_bloc.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_state.dart';
import 'package:hello/blocs/voluntingCamp/voluntCamp_bloc.dart';
import 'package:hello/blocs/voluntingCamp/voluntCamp_event.dart';
import 'package:hello/blocs/voluntingCamp/voluntCamp_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/models/voluntingCampaigns_model.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/ui/view/volunteerCompaign_detail_oage.dart';
import 'package:hello/widgets/elevatedButton.dart';

class VolunteerCampaignsPage extends StatelessWidget {

  VolunteerCampaignsPage({super.key,});

 
@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CampaignBloc(CampaignService())..add(FetchCampaigns()),
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Stack(
            children: [
              // ✅ نفس الهيدر تبعك
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
                child: Image.asset('assets/images/logo2.png',
                    height: 60, width: 60),
              ),

              // زر رجوع
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

              // عنوان
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

              // ✅ جسم الصفحة
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0XFFF2F4EC),
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
                            tabs: const [
                              Tab(text: 'كل الحملات' ),
                              Tab(text: 'جدولة المهام'),
                            ],
                          ),
                        ),

                        Expanded(
                          child: TabBarView(
                            children: [
                              BlocBuilder<CampaignBloc, CampaignState>(
                                builder: (context, state) {
                                  if (state is CampaignLoading) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (state is CampaignLoaded) {
                                    return buildCampaignsList(
                                        context, state.campaigns);
                                  } else if (state is CampaignError) {
                                    return Center(
                                        child: Text(
                                      state.message,
                                      style: const TextStyle(color: Colors.red , fontFamily: 'Zain'),
                                    ));
                                  }
                                  return Container();
                                },
                              ),

 BlocBuilder<ScheduledTasksBloc, ScheduledTasksState>(
                              builder: (context, state) {
                                if (state is ScheduledTasksLoading) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (state is ScheduledTasksError) {
                                  return Center(child: Text('حدث خطأ: ${state.message}'));

                                } 
                                else if (state is NoVolunteerProfile) {
  return Center(
    child: Card(
      color: Colors.orange[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
            const SizedBox(height: 12),
            Text(
               state.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Zain',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

                                else if (state is ScheduledTasksLoaded) {
                                  final tasks = state.tasks;
                                  if (tasks.isEmpty) return Center(child: Text('لا توجد مهام مجدولة'));
                                  return ListView.builder(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: tasks.length,
                                    itemBuilder: (context, index) {
                                      final task = tasks[index];
                                      String currentStatus = task.status;
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return Card(
                                            color: Colors.green[100],
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            margin: const EdgeInsets.only(bottom: 15),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(task.campaignName, textDirection: TextDirection.rtl, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                                  SizedBox(height: 8),
                                                  Text('المهمة: ${task.taskName}', textDirection: TextDirection.rtl),
                                                  SizedBox(height: 8),
                                                  Text('تاريخ الانتهاء: ${task.campaignEndTime}', textDirection: TextDirection.rtl),
                                                  SizedBox(height: 8),
                                                  DropdownButton<String>(
                                                    value: currentStatus,
                                                    items: ['مقبولة', 'انسحاب'].map((status) {
                                                      return DropdownMenuItem<String>(
                                                        value: status,
                                                        child: Text(status),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newStatus) {
                                                      if (newStatus != null) {
                                                        setState(() => currentStatus = newStatus);
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
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),                            ],
                       
                      
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


// Widget buildScheduledList(
//   BuildContext context,
//   List<Map<String, dynamic>> campaigns,
// ) {
//   // final List<Map<String, dynamic>> fakeTasks = [
//   //   {
//   //     'title': 'حملة تنظيف الشاطئ',
//   //     'taskName': 'جمع النفايات البلاستيكية',
//   //     'status': 'مقبولة',
//   //     'endDate': '2025-08-05',
//   //   },
//   //   {
//   //     'title': 'حملة زراعة الأشجار',
//   //     'taskName': 'زرع الأشجار في الحديقة العامة',
//   //     'status': 'مقبولة',
//   //     'endDate': '2025-08-10',
//   //   },
//   // ];

//   return ListView.builder(
//     padding: const EdgeInsets.all(30),
//     itemCount: fakeTasks.length,
//     itemBuilder: (context, index) {
//       final task = fakeTasks[index];
//       String currentStatus = task['status'] ?? 'مقبولة';

//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Card(
//             color: babygreen,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             elevation: 6,
//             margin: const EdgeInsets.only(bottom: 15),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                        textDirection: TextDirection.rtl,
//                     task['title'] ?? '',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: zeti,
//                        fontFamily: 'Zain',
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//              textDirection: TextDirection.rtl,

                  
//                     'المهمة: ${task['taskName'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: medium_Green,
//                        fontFamily: 'Zain',
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                                            textDirection: TextDirection.rtl,

//                     'تاريخ الانتهاء: ${task['endDate'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color:  Color.fromARGB(255, 247, 119, 134),
//                        fontFamily: 'Zain',
//                     ),
//                   ),
//                   SizedBox(height: 16),

//                   DropdownButton<String>(
//                     value: currentStatus,
//                     items: ['مقبولة', 'انسحاب'].map((status) {
//                       return DropdownMenuItem<String>(
//                         value: status,
//                         child: Text(
//                           status,
//                           style: TextStyle(
//                             color: status == 'انسحاب' ?  Color.fromARGB(255, 247, 119, 134) : zeti,
//                              fontFamily: 'Zain',

                      
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (newStatus) {
//                       if (newStatus != null) {
//                         setState(() {
//                           currentStatus = newStatus;
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }

  Widget buildCampaignsList(
    BuildContext context,
    List<CampaignModel> campaigns,
  ) {
    return Container(
      color: const Color(0XFFF2F4EC),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final c = campaigns[index];
          return buildVolunteerCampaignCard(
            imageUrl: c.photo,
            title: c.title,
            status: c.statusType,
            category: c.classificationName,
            tasksCount: c.numberOfTasks.toString(),
            onTap: () {
              int selectedCampaignId = c.id;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsAssociationcamps(campaignId: selectedCampaignId,),
                ),
              );
            },
          );
        },
      ),
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
      onTap: onTap, 

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
                  child: Image.network(
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
                          fontFamily: 'Zain'
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
                                      ? zeti.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color:
                                    isActive
                                        ? zeti
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
                                  color: zeti,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Zain'
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.category_outlined,
                                size: 18,
                                color: zeti,
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
                    color: zeti,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Zain'
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
