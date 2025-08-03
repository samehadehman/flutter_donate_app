import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/core/color.dart';
import 'package:hello/pages/reset_pass.dart';
import 'package:hello/widgets/elevatedButton.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController codeController = TextEditingController();

  void _onVerifyPressed(BuildContext context) {
    if (codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("الرجاء إدخال الكود") , backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResetPasswordPage(email: widget.email)),
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
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
                        'التحقق من البريد',
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
               PinCodeTextField(
  appContext: context,
  length: 6,
  obscureText: false,
  animationType: AnimationType.fade,
  pinTheme: PinTheme(
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(5),
    fieldHeight: 50,
    fieldWidth: 40,
    activeColor: zeti,
    selectedColor: Light_Green,
    inactiveColor: Light_Green,
  ),
  animationDuration: Duration(milliseconds: 300),
  enableActiveFill: false,
  keyboardType: TextInputType.number,
   inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,  
  ],
  onCompleted: (v) {
    codeController.text = v;
  },
  onChanged: (value) {},
),

                const SizedBox(height: 40),
                ElevatedButtonWidget(
                  textElevated: 'تأكيد',
                  height: 40,
                  width: 45,
                  onPressed: () => _onVerifyPressed(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
