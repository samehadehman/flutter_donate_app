import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/pages/verification.dart';
import 'package:hello/widgets/elevatedButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  void _onNextPressed(BuildContext context) async{
      final enteredEmail = emailController.text.trim();

    if (enteredEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("الرجاء إدخال البريد الإلكتروني")),
      );
      return;
    }

final emailRegex = RegExp(r'\S+@\S+\.\S+');
  if (!emailRegex.hasMatch(emailController.text.trim())) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("الرجاء إدخال بريد إلكتروني صالح")),
    );
    return;
  }
 final prefs = await SharedPreferences.getInstance();
  final savedEmail = prefs.getString('user_email');

  if (savedEmail == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("لم يتم العثور على بريد مسجل سابقًا"), backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
    );
    return;
  }

  if (enteredEmail != savedEmail) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("البريد الذي أدخلته لا يطابق البريد المسجل"),backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
    );
    return;
  }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => VerificationPage(email: emailController.text.trim())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/images/Login.png', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.only(top: 307, right: 25, left: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      Text(
                        'نسيت كلمة المرور',
                        style: TextStyle(
                          color: dark_Green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Container(height: 2, width: 110, color: dark_Green),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: emailController,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "أدخل بريدك الإلكتروني",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Light_Green, width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: zeti, width: 2),
                    ),

                    
                  ),

//  validator: (value) {
//                         if (value == null || value.trim().isEmpty) return 'يرجى إدخال البريد';
//                         if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) return 'البريد غير صالح';
//                         return null;
//                       },
                  
                ),
                const SizedBox(height: 40),

                 
              ElevatedButtonWidget(
                              textElevated: 'التالي',
                              height: 40,
                              width: 45,
                              onPressed: () => _onNextPressed(context),
                            )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
