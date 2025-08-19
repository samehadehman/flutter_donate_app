import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
 // final TextEditingController emailController = TextEditingController();

  String? selectedGender;
  String? selectedCity;
  String? imagePath;

  final List<String> genders = ['ذكر', 'أنثى'];
  final List<String> cities = ['دمشق', 'حلب', 'حمص', 'اللاذقية', 'طرطوس', 'حماة'];

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
     // emailController.text = prefs.getString('name') ?? '';
      ageController.text = prefs.getString('age') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      selectedGender = prefs.getString('gender');
      selectedCity = prefs.getString('city');
      
      imagePath = prefs.getString('imagePath');
    });
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
   //  await prefs.setString('email', emailController.text);
    await prefs.setString('age', ageController.text);
    await prefs.setString('gender', selectedGender ?? '');
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('city', selectedCity ?? '');
    if (imagePath != null) {
      await prefs.setString('imagePath', imagePath!);
    }
  }

  // Future<void> pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       imagePath = pickedFile.path;
  //     });
  //   }
  // }

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
                  'تعديل الملف الشخصي',
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
                  icon: Icon( Icons.arrow_forward_ios, color: Color(0XFFF2F4EC)),
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
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: white,
                          backgroundImage: imagePath != null
                              ? FileImage(File(imagePath!))
                              : AssetImage('assets/images/slider1.jpg') as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: GestureDetector(
                           // onTap: pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: dark_Green,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.edit, color: white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    buildTextField("اسم المستخدم", nameController, Icons.person),
                    SizedBox(height: 16),
                    buildTextField("العمر", ageController, Icons.calendar_today,
                        keyboardType: TextInputType.number),
                    SizedBox(height: 16),
                    buildDropdown(
                        "الجنس", genders, selectedGender, Icons.transgender, (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    }),
                    SizedBox(height: 16),
                    buildTextField("رقم الهاتف", phoneController, Icons.phone,
                        keyboardType: TextInputType.phone),
                    SizedBox(height: 16),
                    buildDropdown("المدينة", cities, selectedCity,
                        Icons.location_on, (value) {
                      setState(() {
                        selectedCity = value;
                      });
                    }),
                     SizedBox(height: 24),
              //      buildTextField(" البريد الالكتروني", emailController, Icons.email),
                    SizedBox(height: 32),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: medium_Green,
                        foregroundColor: white,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      icon: Icon(Icons.save),
                      label: Text("حفظ المعلومات",
                          style: TextStyle(fontWeight: FontWeight.bold ,  fontFamily: 'Zain',)),
                      onPressed: () async {
                        await saveProfile();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
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
    );
  }

  Widget buildDropdown(String label, List<String> items, String? selectedValue,
      IconData icon, Function(String?) onChanged) {
        
         if (selectedValue != null && !items.contains(selectedValue)) {
    selectedValue = null;
  }

    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
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
      dropdownColor: white,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item, textAlign: TextAlign.right),
              ))
          .toList(),
    );
  }
}
