import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';
import 'package:hello/widgets/elevatedButton.dart';

class CreateWalletPage extends StatefulWidget {
  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إنشاء المحفظة بنجاح!') , backgroundColor:  Color.fromARGB(255, 247, 119, 134),),
      );
      Navigator.pop(context , true); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                'lib/images/logo2.png',
                height: 60,
                width: 60,
              ),
            ),

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
                  ' إنشاء محفظة',
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
  top: BorderSide(color: dark_Green, width: 2),
),

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                  color: Color(0XFFF2F4EC),
                ),
  
   child:  
     Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
             Text(
              '! يرجى إدخال المبلغ',
                  style: TextStyle(fontSize: 18, color: zeti, fontWeight: FontWeight.bold ,  fontFamily: 'Zain',),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30,),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
               decoration: InputDecoration(
        labelText: 'المبلغ',
        labelStyle: TextStyle(color: dark_Green),
        prefixIcon: Icon(Icons.attach_money, color: dark_Green),
        filled: true,
        fillColor: Light_Green.withOpacity(0.3),
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
                  if (value == null || value.isEmpty) return 'يرجى إدخال المبلغ';
                  if (double.tryParse(value) == null) return 'يرجى إدخال رقم صحيح';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
        labelText: 'كلمة المرور',
        labelStyle: TextStyle(color: dark_Green),
        prefixIcon: Icon(Icons.password_rounded, color: dark_Green),
        filled: true,
        fillColor: Light_Green.withOpacity(0.3),
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
                  if (value == null || value.isEmpty) return 'يرجى إدخال كلمة المرور';
                  if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
        labelText: 'تأكيد كلمة المرور',
        labelStyle: TextStyle(color: dark_Green),
        prefixIcon: Icon(Icons.password, color: dark_Green),
        filled: true,
        fillColor: Light_Green.withOpacity(0.3),
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
                  if (value == null || value.isEmpty) return 'يرجى تأكيد كلمة المرور';
                  if (value != passwordController.text) return 'كلمات المرور غير متطابقة';
                  return null;
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButtonWidget(
                  textElevated: 'إنشاء ',
                              height: 40,
                              width: 30,
                  onPressed:(){ _submit();
                  },
                 
                ),
              ),
            ],
          ),
        ),
      ),
              ))])
    );
  }
}
