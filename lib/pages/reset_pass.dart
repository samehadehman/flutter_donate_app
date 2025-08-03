import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/widgets/elevatedButton.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;
  ResetPasswordPage({super.key, required this.email});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void _onResetPressed(BuildContext context) {
    if (passwordController.text.trim().isEmpty || confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("الرجاء تعبئة جميع الحقول"), backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("كلمتا المرور غير متطابقتين"), backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم تغيير كلمة المرور بنجاح"), backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
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
                        'إعادة تعيين كلمة المرور',
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
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "كلمة المرور الجديدة",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Light_Green, width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: zeti, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "تأكيد كلمة المرور",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Light_Green, width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: zeti, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                 ElevatedButtonWidget(
                              textElevated: 'إعادة تعيين',
                              height: 40,
                              width: 45,
                              onPressed: () => _onResetPressed(context),
                            )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
