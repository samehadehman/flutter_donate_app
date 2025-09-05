import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerprodetail_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerprodetail_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/volunteer_profile_form_page.dart';

import '../../blocs/volunteerFile/volunteerform_bloc.dart';
import '../../blocs/volunteerFile/volunteerform_event.dart';

import '../../blocs/volunteerFile/volunteerform_state.dart';
import '../../models/createvolunteerpro_model.dart';
import '../../models/showVolunteerpro_model.dart';


class VolunteerProfileDetailsPage extends StatelessWidget {
  

  const VolunteerProfileDetailsPage({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VolunteerProfileBloc, VolunteerProfileState>(
      builder: (context, state) {
        if (state is VolunteerProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is VolunteerProfileDetailsLoaded) {
          final profile = state.profile;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: zeti,
              child: Icon(Icons.edit, color: white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VolunteerProfileFormPage(existingProfile: profile),
                  ),
                ).then((_) {
                  // ⚡️ بعد تعديل الملف، نجدد البيانات فورًا
                  context.read<VolunteerProfileBloc>().add(GetVolunteerDetailProfileEvent());
                });
              },
            ),
            body: Stack(
              children: [
                // ✅ الخلفية
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

                // ✅ زر الرجوع
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
                      icon: const Icon(Icons.arrow_forward_ios, color: Color(0XFFF2F4EC)),
                      onPressed: () {
    // ⚡️ قبل الرجوع للصفحة السابقة
    context.read<VolunteerProfileBloc>().add(GetVolunteerProfileEvent());
    Navigator.pop(context);
  },
                    ),
                  ),
                ),

                // ✅ العنوان
                Positioned(
                  top: 20,
                  left: 16,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0X80D9E4D7).withAlpha(85),
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(color: Color(0XFFF2F4EC)),
                    ),
                    child: const Text(
                      'الملف التطوعي',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0XFFF2F4EC),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Zain',
                      ),
                    ),
                  ),
                ),

                // ✅ المحتوى
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Container(
                    height: MediaQuery.of(context).size.height,


decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55),
                      ),
                      color: Color.fromARGB(255, 252, 248, 241),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          buildInfoCard(
                            icon: Icons.star,
                            title: 'المهارات',
                            value: profile.skills.isNotEmpty ? profile.skills : 'لم تتم الإضافة بعد',
                          ),
                          const SizedBox(height: 12),
                          buildInfoCard(
                            icon: Icons.access_time,
                            title: 'أوقات التفرغ',
                            value: profile.availabilityType.availabilityType,
                          ),
                          const SizedBox(height: 12),
                          buildInfoCard(
                            icon: Icons.access_time,
                            title: 'عدد الساعات المتاحة',
                            value: profile.availabilityHours.isNotEmpty
                                ? profile.availabilityHours
                                : 'لم تتم الإضافة بعد',
                          ),
                          const SizedBox(height: 12),
                          buildInfoCard(
                            icon: Icons.favorite,
                            title: 'الأعمال المفضلة',
                            value: profile.preferredTasks.isNotEmpty
                                ? profile.preferredTasks
                                : 'لم تتم الإضافة بعد',
                          ),
                          const SizedBox(height: 12),
                          buildInfoCard(
                            icon: Icons.school,
                            title: 'التخصص الأكاديمي',
                            value: profile.academicMajor.isNotEmpty
                                ? profile.academicMajor
                                : 'لم تتم الإضافة بعد',
                          ),
                          const SizedBox(height: 12),
                          buildInfoCard(
                            icon: Icons.history,
                            title: 'أعمال تطوعية سابقة',
                            value: profile.previousVolunteerWork.isNotEmpty
                                ? profile.previousVolunteerWork
                                : 'لم تتم الإضافة بعد',
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is VolunteerProfileError) {
          return Scaffold(
            body: Center(child: Text("❌ ${state.message}")),
          );
        }

        return const Scaffold(
          body: Center(child: Text("ما في بيانات بعد")),
        );
      },
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: zeti.withOpacity(0.1),


shape: BoxShape.circle,
              ),
              child: Icon(icon, color: zeti, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'Zain',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.4,
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