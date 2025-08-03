import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/main.dart';
import 'package:hello/models/tasks.dart';
import 'package:hello/pages/volunteer_profile_form_page.dart';
import 'package:hello/widgets/elevatedButton.dart';

class DetailsAssociationcamps extends StatelessWidget {
  DetailsAssociationcamps({super.key});

  final List<Task> tasks = [
    Task(
      name: 'توزيع بطانيات',
      description: 'توزيع بطانيات للأسر المحتاجة',
      vacancies: 5,
    ),
    Task(
      name: 'تجهيز مواد غذائية',
      description: 'تجهيز المواد وتعبئتها',
      vacancies: 3,
    ),
    Task(
      name: 'التوصيل',
      description: 'توصيل المواد إلى المنازل',
      vacancies: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF2F4EC),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 429,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: const DecorationImage(
                          image: AssetImage('lib/images/slider1.jpg'),
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
                                  onTap: () {
                                    // ممكن تضيف الرجوع أو أي وظيفة
                                    Navigator.of(context).pop();
                                  },
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
                                children: const [
                                  Text(
                                    'حملة كفالة أيتام',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0XFFF2F4EC),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Zain',
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    '( أيتام )',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0XFFF2F4EC),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Zain',
                                    ),
                                  ),
                                ],
                              ),
                           subtitle: Row(
  children: const [
    Icon(
      Icons.location_on,
      color: Color(0xFFb3beb0),
      size: 16,
    ),
    SizedBox(width: 5),
    Text(
      'ريف دمشق',
      style: TextStyle(
        fontSize: 14,
        color: Color(0XFFF2F4EC),
        fontWeight: FontWeight.w400,
        fontFamily: 'Zain',
      ),
    ),
    SizedBox(width: 29),
    Icon(
      Icons.note_alt,
      color: Color(0xFFb3beb0),
      size: 16,
    ),
    SizedBox(width: 5),
    Text(
      'نشطة',
      style: TextStyle(
        fontSize: 14,
        color: Color(0XFFF2F4EC),
        fontWeight: FontWeight.w400,
        fontFamily: 'Zain',
      ),
    ),
  ],
), // ← هون أضفنا الفاصلة والمغلاق الصحيح
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
                                      '3',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0XFFCE4A43),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Zain',
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
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
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        leading: Container(
                          height: 45,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image: AssetImage('lib/images/slider1.jpg'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        title: const Text(
                          'الشريك المنفذ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0XFF4B4D40),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Zain',
                          ),
                        ),
                        subtitle: const Text(
                          'جمعية إحسان',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 115, 123, 114),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Zain',
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButtonWidget(
                            textElevated: 'التفاصيل',
                            height: 30,
                            width: 1,
                            onPressed: () {
                              // هنا تضع وظيفة تفاصيل الشريك لو في صفحة خاصة
                            },
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      indent: 10,
                      endIndent: 10,
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 13),
                        child: RichText(
                          textDirection: TextDirection.rtl,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'الوصف\n',
                                style: TextStyle(
                                  fontSize: 15.5,
                                  color: Color(0XFF4B4D40),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Zain',
                                ),
                              ),
                              TextSpan(
                                text:
                                    'انضم إلينا في هذه الحملة الهادفة لدعم الأسر المحتاجة خلال فصل الشتاء. نقوم بتوزيع البطانيات والملابس الدافئة والموادالغذائية الأساسية لضمان مرورهم بشتاءآمن ودافئ. مساهمتك تصنع فرقًا حقيقيًا في حياة الآخرين.',
                                style: TextStyle(
                                  fontSize: 14,
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
                    const SizedBox(height: 20),

                    // معلومات الحملة الجديدة
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
                     
                    const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '11:00 - 12:00',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Zain',
              color: Color(0XFF4B4D40),
            ),
          ),
                    SizedBox(width: 6),

                    Icon(Icons.access_time, size: 18, color:  Color.fromARGB(255, 247, 119, 134),),

        ],
      ),

      SizedBox(height: 8),

      // سطر التواريخ
      const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.date_range, size: 18, color:  Color.fromARGB(255, 247, 119, 134),),
          SizedBox(width: 6),
          Text(
            '1/4/2025',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Zain',
              color: Color(0XFF4B4D40),
            ),
          ),
          SizedBox(width: 10),
          Text(
            'إلى',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Zain',
              color: Color(0XFF4B4D40),
            ),
          ),
          SizedBox(width: 10),
          Text(
            '1/3/2025',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Zain',
              color: Color(0XFF4B4D40),
            ),
          ),
          SizedBox(width: 6),
          Icon(Icons.date_range, size: 18, color:  Color.fromARGB(255, 247, 119, 134),),
        ],
      ),
    
                          const SizedBox(height: 15),
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
                    ...List.generate(tasks.length, (index) => TaskCard(task: tasks[index], scaffoldContext: context)),

                        ],
                      ),
                    ),

                  
               
                  ],
                ),
              ],
            ),
          ),
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
class TaskCard extends StatelessWidget {
  final Task task;
  final BuildContext scaffoldContext;
  const TaskCard({required this.task, required this.scaffoldContext, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
        
          context: context,
          builder: (dialogContext) => AlertDialog(
            backgroundColor: babygreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Directionality(
             textDirection: TextDirection.rtl,
               child: Text(task.name, style:  TextStyle(fontFamily: 'Zain', fontWeight: FontWeight.bold , color: zeti))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('الوصف: ${task.description}', style:  TextStyle(fontFamily: 'Zain' , color: dark_Green)),
                const SizedBox(height: 8),
                Text('عدد الشواغر: ${task.vacancies}', style:  TextStyle(fontFamily: 'Zain' , color: dark_Green)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child:  Text('إغلاق', style: TextStyle(fontFamily: 'Zain' , color: zeti , fontWeight: FontWeight.bold , fontSize: 16)),
              ),
              ElevatedButton.icon(
                
                icon:  Icon(Icons.volunteer_activism, size: 18 , color: dark_Green,),
                label:  Text('تطوع الآن', style: TextStyle(fontFamily: 'Zain' , color: zeti , fontWeight: FontWeight.bold , fontSize: 16)),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    SnackBar(
                      content: Text('تم تقديم طلب التطوع لمهمة "${task.name}"'),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Color.fromARGB(255, 247, 119, 134),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow:  [
            BoxShadow(color: medium_Green, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Icon(Icons.task, color: Light_Green),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(task.name, style:  TextStyle(fontFamily: 'Zain', fontWeight: FontWeight.bold , color: zeti)),
                Text('شواغر: ${task.vacancies}', style:  TextStyle(fontFamily: 'Zain' , color: zeti)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}