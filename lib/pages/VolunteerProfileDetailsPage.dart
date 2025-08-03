import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/pages/volunteer_profile_form_page.dart';


class VolunteerProfileDetailsPage extends StatelessWidget {


    final Map<String, dynamic> data;
  const VolunteerProfileDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return 
     Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: dark_Green,
        child: Icon(Icons.edit , color: white,),
        
        
        onPressed: 
      (){
         Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VolunteerProfileFormPage( ),
            ),
         );
      }
      ),
        body: Stack(
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
              child: Image.asset(
                'lib/images/logo2.png',
                height: 60,
                width: 60,
              ),
            ),

            // ✅ الزر في الأعلى اليمين
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
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Color(0XFFF2F4EC)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // ✅ النص في الأعلى اليسار
            Positioned(
              top: 20,
              left: 16,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0X80D9E4D7).withAlpha(85),
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: const Color(0XFFF2F4EC)),
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

            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                  color: Color(0XFFF2F4EC),
                ),
              child:    SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                
                  children: [
                     
                    const SizedBox(height: 24),
            
                    // ✅ البطاقات
                    buildInfoCard(
                      icon: Icons.star,
                      title: 'المهارات',
                      value: data['skills'] ?? 'لم تتم الإضافة بعد',
                    ),
                    const SizedBox(height: 12),
                    buildInfoCard(
                      icon: Icons.access_time,
                      title: 'أوقات التفرغ',
                      value: data['availability'] ?? 'لم تتم الإضافة بعد',
                    ),
            
                     
                    const SizedBox(height: 12),
                    buildInfoCard(
                      icon: Icons.access_time,
                      title: 'عدد الساعات المتاحة',
                      value: data['hours'] ?? 'لم تتم الإضافة بعد',
                    ),
                    const SizedBox(height: 12),
                    buildInfoCard(
                      icon: Icons.favorite,
                      title: 'الأعمال المفضلة',
                      value: data['interests'] ?? 'لم تتم الإضافة بعد',
                    ),
                    const SizedBox(height: 12),
                    buildInfoCard(
                      icon: Icons.school,
                      title: 'التخصص الأكاديمي',
                      value: data['major'] ?? 'لم تتم الإضافة بعد',
                    ),
                    const SizedBox(height: 12),
                    buildInfoCard(
                      icon: Icons.history,
                      title: 'أعمال تطوعية سابقة',
                      value: data['pastVolunteer'] ?? 'لم تتم الإضافة بعد',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              ),
            ),
           
          ],
        ),
   
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.4,
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


