import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/Cities/cities_bloc.dart';
import 'package:hello/blocs/Cities/cities_event.dart';
import 'package:hello/blocs/Cities/cities_state.dart';
import 'package:hello/blocs/profile/mini_bloc.dart';
import 'package:hello/blocs/profile/mini_event.dart';
import 'package:hello/blocs/userinfo/userinfo_bloc.dart';
import 'package:hello/blocs/userinfo/userinfo_event.dart';
import 'package:hello/blocs/userinfo/userinfo_state.dart';
import 'package:hello/models/cities_model.dart';
import 'package:hello/core/color.dart';




class ProfileEditPage extends StatefulWidget {
  
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  int? selectedGenderId;
  City? selectedCity;
  String? selectedGender;

  Map<String, int> gendersMap = {
    'أنثى': 1,
    'ذكر': 2,
  };

  @override
  void initState() {
    super.initState();
    context.read<CityBloc>().add(FetchCities());
  }

  void saveProfileWithBloc() {
    final bloc = BlocProvider.of<UserInfoBloc>(context);
    final selectedCityId = selectedCity?.id;
    final selectedGenderId = selectedGender != null ? gendersMap[selectedGender!] : null;

    print("selectedCity: ${selectedCity?.name}, selectedCityId: $selectedCityId");
    print("selectedGender: $selectedGender, selectedGenderId: $selectedGenderId");

    bloc.add(UpdateUserInfo(
      name: nameController.text,
      phone: phoneController.text.isEmpty ? "" : phoneController.text,
      age: ageController.text.isEmpty ? null : ageController.text,
      gender: selectedGenderId,
      city: selectedCityId,
    ));
  }

  @override
  Widget build(BuildContext context) {
 return BlocListener<UserInfoBloc, UserInfoState>(
  listener: (context, state) {
    if (state is UserInfoUpdated) {
      context.read<UserBloc>().add(LoadUser());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
      Navigator.pop(context);
    } else if (state is UserInfoError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ: ${state.message}")),
      );
    }
  },
  child: Stack(
    children: [
      // 🔹 الخلفية Gradient مع الشعار
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // alignment: Alignment.center,
        // child: Image.asset(
        //   'assets/images/logo2.png', // الشعار
        //   height: 60,
        //   width: 60,
        // ),
      ),

      // 🔹 المحتوى (Scaffold شفاف فوق الخلفية)
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // عنوان
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0X80D9E4D7).withAlpha(85),
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(color: const Color(0XFFF2F4EC)),
                      ),
                      child: const Text(
                        'تعديل الملف الشخصي',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0XFFF2F4EC),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Zain',
                        ),
                      ),
                    ),

                    // زر رجوع
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0X80D9E4D7).withAlpha(85),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Color(0XFFF2F4EC)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Color(0XFFF2F4EC)),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 🔹 جسم الصفحة الأبيض
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -10)),
                  ],
                  color: white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      buildTextField("اسم المستخدم", nameController, Icons.person),
                      const SizedBox(height: 16),
                      buildTextField("العمر", ageController, Icons.calendar_today,
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 16),
                      buildDropdown(
                        "الجنس",
                        gendersMap.keys.toList(),
                        selectedGender,
                        Icons.transgender,
                        (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      buildTextField("رقم الهاتف", phoneController, Icons.phone,
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 16),
                      BlocBuilder<CityBloc, CityState>(
                        builder: (context, state) {
                          if (state is CitiesLoading) {
                            return const CircularProgressIndicator();
                          }
                          if (state is CitiesError) {
                            return Text("خطأ: ${state.message}");
                          }
                          if (state is CitiesLoaded) {
                            return buildDropdown(
                              "المدينة",
                              state.cities.map((c) => c.name).toList(),
                              selectedCity?.name,
                              Icons.location_on,
                              (value) {
                                setState(() {
                                  selectedCity = state.cities.firstWhere((c) => c.name == value);
                                });
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:              Color.fromARGB(255, 115, 123, 114),

                          foregroundColor: white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        icon: const Icon(Icons.save),
                        label: const Text(
                          "حفظ المعلومات",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Zain',
                          ),
                        ),
                        onPressed: saveProfileWithBloc,
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
);


  }

  Widget buildTextField(String label, TextEditingController controller, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: zeti),
        prefixIcon: Icon(icon, color: zeti),
        filled: true,
        fillColor: babygreen.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: zeti, width: 1.5)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: babygreen.withOpacity(0.3))),
      ),
      cursorColor: zeti,
      style: TextStyle(color: zeti),
    );
  }

  Widget buildDropdown(String label, List<String> items, String? selectedValue, IconData icon, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: zeti),
        prefixIcon: Icon(icon, color: zeti),
        filled: true,
        fillColor: babygreen.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: zeti, width: 1.5)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: babygreen.withOpacity(0.3))),
      ),
      dropdownColor: white,
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, textAlign: TextAlign.right))).toList(),
    );
  }
}

// class ProfileEditPage extends StatefulWidget {
//   const ProfileEditPage({super.key});

//   @override
//   State<ProfileEditPage> createState() => _ProfileEditPageState();
// }

// class _ProfileEditPageState extends State<ProfileEditPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

// int? selectedGenderId;   // id للإرسال
// int? selectedCityId;
//   String? selectedGender;
//   String? selectedCity;


// Map<String, int> citiesMap = {
//   'الرياض': 1,
//   'جدة': 2,
//   'الدمام': 3,
//   'مكة': 4,
//   'المدينة': 5,
//   'الخبر': 6,
// };

// Map<String, int> gendersMap = {
//   'أنثى': 1,
//   'ذكر': 2,
  
// };

//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }


//   Future<void> loadProfile() async {
//     final prefs = await SharedPreferences.getInstance();

//      String? cityFromPrefs = prefs.getString('city');
//   int? cityIdFromPrefs = prefs.getInt('cityId');

//   // تحقق إذا المدينة موجودة ضمن الـ map
//   if (cityFromPrefs != null && !citiesMap.containsKey(cityFromPrefs)) {
//     cityFromPrefs = null;
//     cityIdFromPrefs = null;
//   }
//   }

//   void saveProfileWithBloc() {
//     final bloc = BlocProvider.of<UserInfoBloc>(context);
//     final selectedCityId = selectedCity != null ? citiesMap[selectedCity!] : null;
//   final selectedGenderId = selectedGender != null ? gendersMap[selectedGender!] : null;
//   print("selectedCity: $selectedCity, selectedCityId: $selectedCityId");

//     bloc.add(UpdateUserInfo(
//       name: nameController.text,
//       phone: phoneController.text.isEmpty ? "" : phoneController.text,
//       age: ageController.text.isEmpty ? null : ageController.text,
//       gender: selectedGenderId,
//       city: selectedCityId,
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<UserInfoBloc, UserInfoState>(
//       listener: (context, state) async {
//         if (state is UserInfoUpdated) {
//           final prefs = await SharedPreferences.getInstance();
//           // تحديث SharedPreferences لكل الحقول
//           await prefs.setString('name', nameController.text);
//           await prefs.setString('age', ageController.text);
//           await prefs.setString('phone', phoneController.text);
//           await prefs.setString('gender', selectedGender ?? '');
//           await prefs.setString('city', selectedCity ?? '');

//           // تحديث الـ Bloc الآخر حتى يظهر الاسم والجنس والمدينة الجديدة فورًا
//           context.read<UserBloc>().add(LoadUser());
//           context.read<UserInfoBloc>().add(FetchUserInfo());

//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(state.message)));
//           Navigator.pop(context);
//         } else if (state is UserInfoError) {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text("خطأ: ${state.message}")));
//         }
//       },
//       child: Scaffold(
//         backgroundColor: medium_Green,
//         body: Column(
//           children: [
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: const Color(0X80D9E4D7).withAlpha(85),
//                         borderRadius: BorderRadius.circular(90),
//                         border: Border.all(color: Color(0XFFF2F4EC)),
//                       ),
//                       child: const Text(
//                         'تعديل الملف الشخصي',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Color(0XFFF2F4EC),
//                           fontWeight: FontWeight.w600,
//                           fontFamily: 'Zain',
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: const Color(0X80D9E4D7).withAlpha(85),
//                         borderRadius: BorderRadius.circular(50),
//                         border: Border.all(color: Color(0XFFF2F4EC)),
//                       ),
//                       child: IconButton(
//                         icon: Icon(Icons.arrow_forward_ios, color: Color(0XFFF2F4EC)),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 10,
//                         offset: Offset(0, -30))
//                   ],
//                   color: white,
//                   borderRadius:
//                       BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
//                 ),
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 16),
//                       SizedBox(height: 24),
//                       buildTextField("اسم المستخدم", nameController, Icons.person),
//                       SizedBox(height: 16),
//                       buildTextField("العمر", ageController, Icons.calendar_today,
//                           keyboardType: TextInputType.number),
//                       SizedBox(height: 16),
//                       buildDropdown("الجنس",  gendersMap.keys.toList(), selectedGender, Icons.transgender,
//                           (value) {
//                         setState(() {
//                           selectedGender = value;
//                           selectedGenderId = gendersMap[value];
//                         });
//                       }),
//                       SizedBox(height: 16),
//                       buildTextField("رقم الهاتف", phoneController, Icons.phone,
//                           keyboardType: TextInputType.phone),
//                       SizedBox(height: 16),
//                      buildDropdown("المدينة", citiesMap.keys.toList(), selectedCity, Icons.location_on,
//     (value) {
//   setState(() {
//     selectedCity = value;
//     selectedCityId = citiesMap[value]; // هنا نحفظ الـ id الصحيح
//   });
// }),
//                       SizedBox(height: 32),
//                       ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: medium_Green,
//                             foregroundColor: white,
//                             minimumSize: Size(double.infinity, 50),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15))),
//                         icon: Icon(Icons.save),
//                         label: Text("حفظ المعلومات",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontFamily: 'Zain')),
//                         onPressed: saveProfileWithBloc,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(String label, TextEditingController controller, IconData icon,
//       {TextInputType keyboardType = TextInputType.text}) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: zeti),
//         prefixIcon: Icon(icon, color: zeti),
//         filled: true,
//         fillColor: babygreen.withOpacity(0.3),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: zeti, width: 1.5)),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: babygreen.withOpacity(0.3))),
//       ),
//       cursorColor: zeti,
//       style: TextStyle(color: zeti),
//     );
//   }

//   Widget buildDropdown(String label, List<String> items, String? selectedValue,
//       IconData icon, Function(String?) onChanged) {
        
//     if (selectedValue != null && !items.contains(selectedValue)) selectedValue = null;
//     return DropdownButtonFormField<String>(
//       value: selectedValue,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: zeti),
//         prefixIcon: Icon(icon, color: zeti),
//         filled: true,
//         fillColor: babygreen.withOpacity(0.3),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: zeti, width: 1.5)),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: babygreen.withOpacity(0.3))),
//       ),
//       dropdownColor: white,
//       items: items
//           .map((item) =>
//               DropdownMenuItem(value: item, child: Text(item, textAlign: TextAlign.right)))
//           .toList(),
//     );
//   }
// }
