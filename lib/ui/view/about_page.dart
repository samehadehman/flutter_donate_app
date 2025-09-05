import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/VolunteerProfileDetailsPage.dart';
import 'package:hello/ui/view/home_page.dart';
import 'package:hello/ui/view/profilePage.dart';
import 'package:hello/widgets/NavBar.dart';


class AboutPage extends StatelessWidget {
  
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 3, onTap: (index ) {  },),

      body: 
      Stack(
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
                'assets/images/logo2.png',
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
                  ' المزيد',
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
                decoration:  BoxDecoration(
                   boxShadow: [
                    BoxShadow(
                      color: babygreen.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -15),
                    ),
                  ],
           border: Border(
  top: BorderSide(color: zeti, width: 2),
),

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                  color: const Color.fromARGB(255, 252, 248, 241),
                ),
            
   child:  
    ListView(
        padding: const EdgeInsets.only(left:16 , right: 16 , top: 70),
        children: [
          buildAboutCard(
            context,
            icon: Icons.info_outline,
            title: 'عن تراحم',
            subtitle: 'تعرف على رسالتنا وأهدافنا في دعم المحتاجين.',
            onTap: () {
              showSectionDialog(
                context,
                'عن تراحم',
                'تراحم هو تطبيق يهدف إلى تنظيم حملات التبرع وتسهيل وصول المساعدات إلى المستحقين بسرعة وكفاءة، مع التركيز على الشفافية والعمل التطوعي.',
              );
            },
          ),
          const SizedBox(height: 12),
          buildAboutCard(
            context,
            icon: Icons.group,
            title: 'جمعيات تراحم',
            subtitle: 'تعرف على الجمعيات المشاركة في مبادرات تراحم.',
            onTap: () {
              showSectionDialog(
                context,
                'جمعيات تراحم',
                'يشارك في تطبيق تراحم أكثر من 38 جمعية خيرية مرخصة تعمل بالتعاون مع فرق تطوعية لتغطية مختلف أنواع المساعدات للمحتاجين.',
              );
            },
          ),
          const SizedBox(height: 12),
          buildAboutCard(
            context,
            icon: Icons.question_answer,
            title: 'الأسئلة الشائعة',
            subtitle: 'إجابات لأهم الأسئلة حول استخدام التطبيق.',
            onTap: () {
              showSectionDialog(
                context,
                'الأسئلة الشائعة',
                '١. كيف أتبرع؟\nيمكنك التبرع عبر الضغط على أي حالة ثم الضغط على زر "تبرع".\n\n٢. هل يوجد حد أدنى للتبرع؟\nلا يوجد حد أدنى محدد، يمكنك المساهمة بأي مبلغ.\n\n٣. كيف أضمن وصول التبرع؟\nنحرص على توثيق عمليات التبرع بالتعاون مع الجمعيات المشاركة.',
              );
            },
          ),
          const SizedBox(height: 12),
          buildAboutCard(
            context,
            icon: Icons.privacy_tip,
            title: 'سياسة الخصوصية',
            subtitle: 'كيفية تعامل التطبيق مع بياناتك.',
            onTap: () {
              showSectionDialog(
                context,
                'سياسة الخصوصية',
                'نحترم خصوصيتك، ولا نقوم بمشاركة بياناتك الشخصية مع أي جهة خارجية دون إذنك. يتم استخدام بياناتك لتسهيل عمليات التبرع وضمان وصول المساعدات للمستحقين.',
              );
            },
          ),
        ],
      ),
                ) 
                 )
          ]
            )

    );
  }

  Widget buildAboutCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Material(
      ///////////////////////
      color:const Color(0xFFb3beb0),

      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        splashColor: white.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: medium_Green.withOpacity(0.1),
                child: Icon(icon, color: zeti, size: 28),
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
                        fontSize: 16,
                         fontFamily: 'Zain',
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
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
               Icon(Icons.arrow_forward_ios, size: 16, color: zeti),
            ],
          ),
        ),
      ),
    );
  }

  void showSectionDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: zeti,
            fontWeight: FontWeight.bold,
            fontSize: 18,
             fontFamily: 'Zain',
          ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15,
             fontFamily: 'Zain',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'إغلاق',
              style: TextStyle(
                color: medium_Green,
                fontWeight: FontWeight.bold,
                 fontFamily: 'Zain',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
