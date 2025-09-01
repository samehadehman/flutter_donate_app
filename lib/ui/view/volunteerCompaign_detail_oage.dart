import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/voluntingCamp/task_bloc.dart';
import 'package:hello/blocs/voluntingCamp/task_event.dart';
import 'package:hello/blocs/voluntingCamp/task_state.dart';
import 'package:hello/blocs/voluntingCamp/voluntCampDetail_bloc.dart';
import 'package:hello/blocs/voluntingCamp/voluntCampDetail_event.dart';
import 'package:hello/blocs/voluntingCamp/voluntCampDetail_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/models/voluntingCampaignDetails_model.dart';
import 'package:hello/services/voluntingCampaigns_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DetailsAssociationcamps extends StatefulWidget {
  final int campaignId;

  DetailsAssociationcamps({super.key, required this.campaignId ,});

  @override
  State<DetailsAssociationcamps> createState() => _DetailsAssociationcampsState();
}

class _DetailsAssociationcampsState extends State<DetailsAssociationcamps> {

  String token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final t = prefs.getString('auth_token') ?? '';
    setState(() {
      token = t;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      
      create: (context) =>
          CampaignDetailsBloc(CampaignService())..add(FetchCampaignDetails(widget.campaignId)),
      child: Scaffold(
        backgroundColor: const Color(0XFFF2F4EC),
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
            builder: (context, state)  {
              if (state is DetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DetailsLoaded) {
                final CampaignDetailsModel campaign = state.campaign;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // صورة الحملة
                     Stack(
  children: [
    Container(
      height: 429,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(
          image: NetworkImage(campaign.photo), // استخدم رابط الصورة
          fit: BoxFit.cover,
        ),
                             
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 429,
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
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 125,
                                        height: 33,
                                        decoration: BoxDecoration(
                                          color: const Color(0X80D9E4D7).withAlpha(85),
                                          borderRadius: BorderRadius.circular(90),
                                          border: Border.all(
                                            color: const Color(0XFFF2F4EC),
                                          ),
                                        ),
                                        child: const Text(
                                          'التفاصيل',
                                          style: TextStyle(
                                            fontSize: 23,
                                            color: Color(0XFFF2F4EC),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Zain',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 125),
                                      GestureDetector(
                                        onTap: () => Navigator.of(context).pop(),
                                        child: Container(
                                          width: 33,
                                          height: 33,
                                          decoration: BoxDecoration(
                                            color: const Color(0X80D9E4D7).withAlpha(85),
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(
                                              color: const Color(0XFFF2F4EC),
                                            ),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 22,
                                              color: Color(0XFFF2F4EC),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 300),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            campaign.title ?? "بدون عنوان",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Color(0XFFF2F4EC),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Zain',
                                            ),
                                            maxLines: null,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '(${campaign.classificationName ?? "غير مصنف"})',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0XFFF2F4EC),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Zain',
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Color(0xFFb3beb0),
                                          size: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          campaign.location ?? 'غير محدد',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0XFFF2F4EC),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Zain',
                                          ),
                                        ),
                                        const SizedBox(width: 29),
                                        const Icon(
                                          Icons.note_alt,
                                          color: Color(0xFFb3beb0),
                                          size: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          campaign.statusType ?? "غير معروف",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0XFFF2F4EC),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Zain',
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Container(
                                      height: 30,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(150),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${campaign.numberOfTasks ?? 0}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0XFFCE4A43),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Zain',
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'مهمات',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF4B4D40),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Zain',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // الوصف
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(horizontal: 13),
                              child: RichText(
                                textDirection: TextDirection.rtl,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'الوصف\n',
                                      style: TextStyle( 
                                        fontSize: 18,
                                        color: Color(0XFF4B4D40),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Zain',
                                      ),
                                    ),
                                    TextSpan(
                                      text: campaign.description ?? 'لا يوجد وصف متاح',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 115, 123, 114),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Zain',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                           Divider(
                      color: Colors.grey.shade400,
                      indent: 20,
                      endIndent: 20,
                    ),
                          const SizedBox(height: 10),
                          // معلومات الحملة
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'معلومات الحملة',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Zain',
                                    color: Color(0XFF4B4D40),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '(${campaign.tasksTime ?? "-"})',
                                      //${campaign.startDate ?? "?"} - ${campaign.endDate ?? "?"} 
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Zain',
                                        color: Color(0XFF4B4D40),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      Icons.access_time,
                                      size: 18,
                                      color: Color.fromARGB(255, 247, 119, 134),
                                    ),
                                  ],
                                ),
                                  SizedBox(height: 8),
                                   Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.date_range, size: 18, color:  Color.fromARGB(255, 247, 119, 134),),
          const SizedBox(width: 6),
          Text(
            campaign.startDate,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Zain',
              color: Color(0XFF4B4D40),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'إلى',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Zain',
              color: Color(0XFF4B4D40),
            ),
          ),
          const SizedBox(width: 10),
           Text(
            '${campaign.endDate ?? "?"}',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Zain',
              color: Color(0XFF4B4D40),
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.date_range, size: 18, color:  Color.fromARGB(255, 247, 119, 134),),
        ],
      ),
               Divider(
                      color: Colors.grey.shade400,
                      indent: 20,
                      endIndent: 20,
                    ),
                                const SizedBox(height: 10),
                                const Text(
                                  'مهام الحملة',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Zain',
                                    color: Color(0XFF4B4D40),
                                  ),
                                ),
                                const SizedBox(height: 10),

                              campaign.tasks.isEmpty
    ? Text('ما في مهام حالياً' ,     
      style: TextStyle(fontFamily: 'Zain', fontSize: 14, color: Colors.grey),
)
    : Column(
        children: campaign.tasks
           .map(
            (task) => TaskCard(
              task: task,
              scaffoldContext: context,
              token: token,
                service: CampaignService(), // << لازم تضيفه

            ),
          )
            .toList(),
      )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state is DetailsError) {
                return Center(child: Text('حدث خطأ: ${state.message}'));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

// Widget لعرض كل مهمة
class TaskCard extends StatelessWidget {
  final Task task;
  final BuildContext scaffoldContext;
  final String token;
  final CampaignService service;

  const TaskCard({
    required this.task,
    required this.scaffoldContext,
    required this.token,
    required this.service,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final taskBloc = TaskBloc(service);
        taskBloc.add(FetchTaskDetails(taskId: task.id, token: token));

        showDialog(
          context: context,
          builder: (dialogContext) {
            return BlocProvider.value(
              value: taskBloc,
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TaskError) {
                    return AlertDialog(
                      content: Text('حدث خطأ: ${state.message}',
                          style: TextStyle(fontFamily: 'Zain', color: zeti)),
                    );
                  } else if (state is TaskLoaded) {
                    final detailedTask = state.task;
                    return AlertDialog(
                      backgroundColor: babygreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          detailedTask.taskName,
                          style: TextStyle(
                              fontFamily: 'Zain',
                              fontWeight: FontWeight.bold,
                              color: zeti),
                        ),
                      ),
                      content: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الوصف: ${detailedTask.description}',
                              style: TextStyle(fontFamily: 'Zain', color: zeti),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'عدد الشواغر: ${detailedTask.numberVolunterNeed} متاح',
                              style: TextStyle(fontFamily: 'Zain', color: zeti),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'عدد الساعات: ${detailedTask.hours}',
                              style: TextStyle(fontFamily: 'Zain', color: zeti),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text(
                            'إغلاق',
                            style: TextStyle(
                                fontFamily: 'Zain',
                                color: zeti,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.volunteer_activism, size: 18, color: zeti),
                          label: Text(
                            'تطوع الآن',
                            style: TextStyle(
                                fontFamily: 'Zain',
                                color: zeti,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'تم تقديم طلب التطوع لمهمة "${detailedTask.taskName}"'),
                                duration: Duration(seconds: 3),
                                backgroundColor: Color.fromARGB(255, 247, 119, 134),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return AlertDialog(
                      content: Text('لا توجد بيانات',
                          style: TextStyle(fontFamily: 'Zain', color: zeti)),
                    );
                  }
                },
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: medium_Green, blurRadius: 6, offset: Offset(0, 3))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.task, color: Light_Green),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(task.taskName,
                    style: TextStyle(
                        fontFamily: 'Zain', fontWeight: FontWeight.bold, color: zeti)),
                Text('شواغر: ${task.numberVolunterNeed}',
                    style: TextStyle(fontFamily: 'Zain', color: zeti)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class IconWithText extends StatelessWidget {
  final IconData icon;
  final String label;
  const IconWithText({required this.icon, required this.label, super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Zain', fontSize: 13)),
        const SizedBox(width: 4),
        Icon(icon, size: 16, color: Color.fromARGB(255, 247, 119, 134)),
      ],
    );
  }
}
