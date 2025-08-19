// // volunteer_profile_form_page.dart

// import 'package:flutter/material.dart';
// import 'package:hello/core/color.dart';
// import 'package:hello/widgets/elevatedButton.dart';

// class VolunteerProfileFormPage extends StatefulWidget {
//   const VolunteerProfileFormPage({super.key});

//   @override
//   State<VolunteerProfileFormPage> createState() => _VolunteerProfileFormPageState();
// }

// class _VolunteerProfileFormPageState extends State<VolunteerProfileFormPage> {
//   final TextEditingController skillsController = TextEditingController();
//   final TextEditingController availabilityController = TextEditingController();
//   final TextEditingController interestsController = TextEditingController();
//   final TextEditingController majorController = TextEditingController();
//   final TextEditingController pastVolunteerController = TextEditingController();

// final TextEditingController hoursController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

// final List<String> availabilityOptions = [
//   'يوميًا',
//   'أسبوعيًا',

// ];
// String? selectedAvailability;


//   @override
//   void dispose() {
//     skillsController.dispose();
//     availabilityController.dispose();
//     interestsController.dispose();
//     majorController.dispose();
//     pastVolunteerController.dispose();
//     super.dispose();
//   }

//   void _submit() {
//   if (_formKey.currentState!.validate()) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('تم إنشاء الملف التطوعي بنجاح!')),
//     );

//     // ✅ رجّع بيانات ثابتة عند الضغط على "نعم"
//     Navigator.pop(context, {
//       'name': 'يزن أبو العيال',
//       'date': '20-07-2025',
//     });
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: medium_Green,
//       body: Column(
//         children: [
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: const Color(0X80D9E4D7).withAlpha(85),
//                       borderRadius: BorderRadius.circular(90),
//                       border: Border.all(color: Color(0XFFF2F4EC)),
//                     ),
//                     child: const Text(
//                       'ملف التطوع',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Color(0XFFF2F4EC),
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Zain',
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: const Color(0X80D9E4D7).withAlpha(85),
//                       borderRadius: BorderRadius.circular(50),
//                       border: Border.all(color: Color(0XFFF2F4EC)),
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_forward_ios, color: Color(0XFFF2F4EC)),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 40),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     offset: Offset(0, -30),
//                   ),
//                 ],
//                 color: white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(70),
//                   topRight: Radius.circular(70),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(16),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       SizedBox(height: 16),
//                       CircleAvatar(
//                         radius: 56,
//                     backgroundColor: white,
                      
//                         backgroundImage: AssetImage('lib/images/logo.png'),
//                       ),
//                       SizedBox(height: 30),
//                       buildTextField("المهارات", skillsController, Icons.star),
//                       SizedBox(height: 16),
//                       buildAvailabilityDropdown(),
//                       SizedBox(height: 16),
//                      if (selectedAvailability == 'يوميًا' || selectedAvailability == 'أسبوعيًا') ...[
//                                  buildTextField("عدد الساعات المتاحة", hoursController, Icons.timelapse),
//                            SizedBox(height: 16),
//                             ],
                  
                  
//                       buildTextField("الأعمال المفضلة", interestsController, Icons.favorite),
//                       SizedBox(height: 16),
//                       buildTextField("التخصص الأكاديمي", majorController, Icons.school),
//                       SizedBox(height: 16),
//                       buildTextField("أعمال تطوعية سابقة", pastVolunteerController, Icons.history),
//                       SizedBox(height: 32),
//                       ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: medium_Green,
//                           foregroundColor: white,
//                           minimumSize: Size(double.infinity, 50),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         icon: Icon(Icons.check_circle),
//                         label: Text("تأكيد المعلومات",
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                         onPressed: () {
//                              if (_formKey.currentState!.validate()) {
//                           showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               backgroundColor: babygreen,
//                               content: Text(
//                                 'هل أنت متأكد من معلوماتك؟',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(color: Color.fromARGB(255, 18, 30, 19)),
//                               ),
//                               actionsAlignment: MainAxisAlignment.spaceEvenly,
//                               actions: [
//                                 TextButton(
//                                   style: TextButton.styleFrom(foregroundColor: zeti),
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text('تعديل'),
//                                 ),
//                                 TextButton(
//                                   style: TextButton.styleFrom(foregroundColor: zeti),
//                                   onPressed:(){
//                               Navigator.pop(context);
//                         _submit();
//                                     // Navigator.pop(context, {
//                                     },  //   'name': 'يزن أبو العيال',
//                                     //   'date': '20-07-2025',
//                                     //   'skills': skillsController.text,
//                                     //   'availability': selectedAvailability ?? '',
//                                     //   'hours': hoursController.text,
//                                     //   'interests': interestsController.text,
//                                     //   'major': majorController.text,
//                                     //   'pastVolunteer': pastVolunteerController.text,
//                                     // });
                                 
//                                   child: const Text('نعم'),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
//                         }
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTextField(String label, TextEditingController controller, IconData icon) {
//     return TextFormField(
//       controller: controller,
//       textAlign: TextAlign.right,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: dark_Green),
//         prefixIcon: Icon(icon, color: dark_Green),
//         filled: true,
//         fillColor: babygreen.withOpacity(0.3),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: dark_Green, width: 1.5),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: babygreen.withOpacity(0.3)),
//         ),
//       ),
//       cursorColor: dark_Green,
//       style: TextStyle(color: dark_Green),
//       validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'الرجاء تعبئة هذا الحقل';
//       }
//       return null;
//     },
//     );
//   }

//   Widget buildAvailabilityDropdown() {
//   return DropdownButtonFormField<String>(
//     value: selectedAvailability,
//     items: availabilityOptions
//         .map((option) => DropdownMenuItem(
//               value: option,
//               child: Text(option, textAlign: TextAlign.right),
//             ))
//         .toList(),
//   onChanged: (value) {
//   setState(() {
//     selectedAvailability = value;
//     if (selectedAvailability != 'يوميًا' && selectedAvailability != 'أسبوعيًا') {
//       hoursController.clear(); // تفريغ عند إخفاء الحقل
//     }
//   });
// },

//     decoration: InputDecoration(
//       labelText: "أوقات التفرغ",
//       labelStyle: TextStyle(color: dark_Green),
//       prefixIcon: Icon(Icons.access_time, color: dark_Green),
//       filled: true,
//       fillColor: babygreen.withOpacity(0.3),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide(color: dark_Green, width: 1.5),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide(color: babygreen.withOpacity(0.3)),
//       ),
//     ),
//     dropdownColor: white,
//     iconEnabledColor: dark_Green,
//   );
// }
// }
import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';

class VolunteerProfileFormPage extends StatefulWidget {
  const VolunteerProfileFormPage({super.key});

  @override
  State<VolunteerProfileFormPage> createState() => _VolunteerProfileFormPageState();
}

class _VolunteerProfileFormPageState extends State<VolunteerProfileFormPage> {
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();
  final TextEditingController interestsController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController pastVolunteerController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<String> availabilityOptions = ['يوميًا', 'أسبوعيًا'];
  String? selectedAvailability;

  @override
  void dispose() {
    skillsController.dispose();
    availabilityController.dispose();
    interestsController.dispose();
    majorController.dispose();
    pastVolunteerController.dispose();
    hoursController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.pop(context, {
      'skills': skillsController.text,
      'availability': selectedAvailability ?? '',
      'hours': hoursController.text,
      'interests': interestsController.text,
      'major': majorController.text,
      'pastVolunteer': pastVolunteerController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: medium_Green,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0X80D9E4D7).withAlpha(85),
                      borderRadius: BorderRadius.circular(90),
                      border: Border.all(color: Color(0XFFF2F4EC)),
                    ),
                    child: const Text(
                      'ملف التطوع',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0XFFF2F4EC),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Zain',
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0X80D9E4D7).withAlpha(85),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0XFFF2F4EC)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Color(0XFFF2F4EC)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -30),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      SizedBox(height: 30),
                      buildTextField("المهارات", skillsController, Icons.star),
                      SizedBox(height: 16),
                      buildAvailabilityDropdown(),
                      SizedBox(height: 16),
                      if (selectedAvailability == 'يوميًا' || selectedAvailability == 'أسبوعيًا') ...[
                        buildTextField("عدد الساعات المتاحة", hoursController, Icons.timelapse),
                        SizedBox(height: 16),
                      ],
                      buildTextField("الأعمال المفضلة", interestsController, Icons.favorite),
                      SizedBox(height: 16),
                      buildTextField("التخصص الأكاديمي", majorController, Icons.school),
                      SizedBox(height: 16),
                      buildTextField("أعمال تطوعية سابقة", pastVolunteerController, Icons.history),
                      SizedBox(height: 32),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: medium_Green,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        icon: Icon(Icons.check_circle),
                        label: Text("تأكيد المعلومات", style: TextStyle(fontWeight: FontWeight.bold ,  fontFamily: 'Zain',)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Color(0xFFDFF6E1), 
                                content: Text(
                                  'هل أنت متأكد من معلوماتك؟',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Color.fromARGB(255, 18, 30, 19)),
                                ),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: Colors.green.shade800),
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text('تعديل'),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: Colors.green.shade800),
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text('نعم'),
                                  ),
                                ],
                              ),
                            );

                            if (confirmed == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('تم إنشاء الملف التطوعي بنجاح!'),backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
                              );
                              _submit();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: dark_Green),
        prefixIcon: Icon(icon, color: dark_Green),
        filled: true,
        fillColor: babygreen.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: dark_Green, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: babygreen.withOpacity(0.3)),
        ),
      ),
      cursorColor: dark_Green,
      style: TextStyle(color: dark_Green),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء تعبئة هذا الحقل';
        }
        return null;
      },
    );
  }

  Widget buildAvailabilityDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedAvailability,
      items: availabilityOptions
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option, textAlign: TextAlign.right),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedAvailability = value;
          if (selectedAvailability != 'يوميًا' && selectedAvailability != 'أسبوعيًا') {
            hoursController.clear();
          }
        });
      },
      decoration: InputDecoration(
        labelText: "أوقات التفرغ",
        labelStyle: TextStyle(color: dark_Green),
        prefixIcon: Icon(Icons.access_time, color: dark_Green),
        filled: true,
        fillColor: babygreen.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: dark_Green, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: babygreen.withOpacity(0.3)),
        ),
      ),
      dropdownColor: Colors.white,
      iconEnabledColor: dark_Green,
    );
  }
}
