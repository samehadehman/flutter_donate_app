// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hello/core/color.dart';
// import 'package:hello/ui/view/reset_pass.dart';
// import 'package:hello/widgets/elevatedButton.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';


// class VerificationPage extends StatefulWidget {
//   final String email;
//   const VerificationPage({super.key, required this.email});

//   @override
//   State<VerificationPage> createState() => _VerificationPageState();
// }

// class _VerificationPageState extends State<VerificationPage> {
//   final TextEditingController codeController = TextEditingController();

//   void _onVerifyPressed(BuildContext context) {
//     if (codeController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("الرجاء إدخال الكود") , backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
//       );
//       return;
//     }
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => ResetPasswordPage(email: widget.email)),
//     );
//   }

//   @override
//   void dispose() {
//     codeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset('assets/images/Login.png', fit: BoxFit.cover),
//           Padding(
//             padding: const EdgeInsets.only(top: 307, right: 25, left: 20),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Column(
//                     children: [
//                       Text(
//                         'التحقق من البريد',
//                         style: TextStyle(
//                           color: dark_Green,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                            fontFamily: 'Zain',
//                         ),
//                       ),
//                       const SizedBox(height: 9),
//                       Container(height: 2, width: 110, color: dark_Green),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                PinCodeTextField(
//   appContext: context,
//   length: 6,
//   obscureText: false,
//   animationType: AnimationType.fade,
//   pinTheme: PinTheme(
//     shape: PinCodeFieldShape.box,
//     borderRadius: BorderRadius.circular(5),
//     fieldHeight: 50,
//     fieldWidth: 40,
//     activeColor: zeti,
//     selectedColor: Light_Green,
//     inactiveColor: Light_Green,
//   ),
//   animationDuration: Duration(milliseconds: 300),
//   enableActiveFill: false,
//   keyboardType: TextInputType.number,
//    inputFormatters: [
//     FilteringTextInputFormatter.digitsOnly,  
//   ],
//   onCompleted: (v) {
//     codeController.text = v;
//   },
//   onChanged: (value) {},
// ),

//                 const SizedBox(height: 40),
//                 ElevatedButtonWidget(
//                   textElevated: 'تأكيد',
//                   height: 40,
//                   width: 45,
//                   onPressed: () => _onVerifyPressed(context),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_bloc.dart';
import 'package:hello/blocs/forgetpass/forget_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/ui/view/reset_pass.dart';
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
        SnackBar(
          content: Text("الرجاء إدخال الكود"),
          backgroundColor: Color.fromARGB(255, 247, 119, 134),
        ),
      );
      return;
    }

    // إرسال الحدث للبلوك للتحقق من الكود
    context.read<ForgotPasswordBloc>().add(
SubmitCodeEvent(email: widget.email, code: codeController.text.trim())
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
          Image.asset('assets/images/Login.png', fit: BoxFit.cover),
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
                          fontFamily: 'Zain',
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
                  onCompleted: (v) => codeController.text = v,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 40),
                ElevatedButtonWidget(
                  textElevated: 'تأكيد',
                  height: 40,
                  width: 45,
                  onPressed: () => _onVerifyPressed(context),
                ),
                const SizedBox(height: 20),

                // هنا نراقب حالة البلوك
                BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is CodeVerificationSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResetPasswordPage(email: widget.email),
                        ),
                      );
                    } else if (state is ForgotPasswordFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Color.fromARGB(255, 247, 119, 134),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgotPasswordLoading) {
                      return CircularProgressIndicator(
                        color: dark_Green,
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
