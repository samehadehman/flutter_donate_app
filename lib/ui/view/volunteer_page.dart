import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/models/scheduledTask_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hello/blocs/voluntingCamp/scheduledTasks_bloc.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_state.dart';
import 'package:hello/blocs/voluntingCamp/task_bloc.dart';
import 'package:hello/blocs/voluntingCamp/task_event.dart';
import 'package:hello/blocs/voluntingCamp/voluntCamp_bloc.dart';
import 'package:hello/blocs/voluntingCamp/voluntCamp_event.dart';
import 'package:hello/blocs/voluntingCamp/voluntCamp_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/models/voluntingCampaigns_model.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:hello/ui/view/volunteerCompaign_detail_oage.dart';
import 'package:hello/blocs/voluntingCamp/scheduledTasks_event.dart';

class VolunteerCampaignsPage extends StatelessWidget {
  static String id = "Camp";

  VolunteerCampaignsPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  CampaignBloc(CampaignService())..add(FetchCampaigns()),
        ),
        BlocProvider(
          create:
              (context) =>
                  ScheduledTasksBloc(CampaignService())
                    ..add(FetchScheduledTasks()),
        ),
        BlocProvider(create: (context) => TaskBloc(CampaignService())),
      ],
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Stack(
            children: [
              // الهيدر
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

              // الجسم
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
                              Tab(text: 'كل الحملات'),
                              Tab(text: 'جدولة المهام'),
                            ],
                          ),
                        ),

                        Expanded(
                          child: TabBarView(
                            children: [
                              // كل الحملات
                              BlocBuilder<CampaignBloc, CampaignState>(
                                builder: (context, state) {
                                  if (state is CampaignLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is CampaignLoaded) {
                                    return buildCampaignsList(
                                      context,
                                      state.campaigns,
                                    );
                                  } else if (state is CampaignError) {
                                    return Center(
                                      child: Text(
                                        state.message,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Zain',
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),

                              BlocBuilder<
                                ScheduledTasksBloc,
                                ScheduledTasksState
                              >(
                                builder: (context, state) {
                                  if (state is ScheduledTasksLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is ScheduledTasksError) {
                                    return Center(
                                      child: Text('حدث خطأ: ${state.message}'),
                                    );
                                  } else if (state is NoVolunteerProfile) {
                                    return Center(
                                      child: Text(
                                        state.message,
                                        style: const TextStyle(
                                          color: Colors.orange,
                                        ),
                                      ),
                                    );
                                  } else if (state is ScheduledTasksLoaded) {
                                    final tasks = state.tasks;
                                    print(
                                      "🎯 ScheduledTasksLoaded فيه ${state.tasks.length} مهام",
                                    );

                                    if (tasks.isEmpty) {
                                      return const Center(
                                        child: Text('لا توجد مهام مجدولة'),
                                      );
                                    }

return ListView.builder(
  padding: const EdgeInsets.all(30),
  itemCount: tasks.length,
  itemBuilder: (context, index) {
    final task = tasks[index];
    int currentStatusId = task.statusId; // الحالة من الباك مباشرة

    return Card(
      color: babygreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              task.campaignName,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: zeti,
              ),
            ),
            const SizedBox(height: 8),
            Text('المهمة: ${task.taskName}',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: zeti)),
            const SizedBox(height: 8),
            Text('تاريخ الانتهاء: ${task.campaignEndTime}',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: zeti)),
            const SizedBox(height: 8),

            // الحالة
            Text(
              'الحالة: ${task.status ?? "غير معروف"}',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: zeti,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // زر الاعتذار يطلع بس إذا الحالة "قادمة" (1)
            if (currentStatusId == 1)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  print("🔴 تم الاعتذار عن Task ${task.taskId}");

                  // ابعت تحديث للباك
                  context.read<TaskBloc>().add(
                        UpdateTaskStatus(
                          taskId: task.taskId,
                          statusId: 3, // اعتذار
                        ),
                      );

                  // رجّع تحديث القائمة من الباك
                  context
                      .read<ScheduledTasksBloc>()
                      .add(FetchScheduledTasks());
                },
                child: const Text(
                  'اعتذار',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Zain',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  },
);

                                  }
                                  return Container();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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

  /// قائمة الحملات
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DetailsAssociationcamps(campaignId: c.id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// كرت حملة
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
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
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
                          fontFamily: 'Zain',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
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
                                        : const Color.fromARGB(
                                          255,
                                          247,
                                          119,
                                          134,
                                        ),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: zeti,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Zain',
                                ),
                              ),
                              const SizedBox(width: 6),
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
            const SizedBox(height: 12),
            Divider(color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$tasksCount مهام',
                  style: TextStyle(
                    color: zeti,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Zain',
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
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
