import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/wallet/wallet_bloc.dart';
import 'package:hello/blocs/wallet/wallet_event.dart';
import 'package:hello/core/color.dart';
import 'package:hello/widgets/elevatedButton.dart';

class CreateWalletPage extends StatefulWidget {

  final bool isEdit;
  final String? currentAmount;

    CreateWalletPage({this.isEdit = false, this.currentAmount});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();



 @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.currentAmount != null) {
      amountController.text = widget.currentAmount!;
    }
  }


  @override
  void dispose() {
    amountController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

 void _submit() {
    if (_formKey.currentState!.validate()) {
      final amount = int.tryParse(amountController.text) ?? 0;

       if (amount == null) {
      // لو القيمة مش رقم صحيح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى إدخال رقم صحيح للمبلغ")),
      );
      return;
    }
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

    print("Submitting amount: $amount");
 if (widget.isEdit) {
        context.read<WalletBloc>().add(UpdateWallet(
    amount: amount, // <--- int

            ));
      } else {
        context.read<WalletBloc>().add(CreateWallet(
              amount: amount,
              password: password,
              confirmPassword: confirmPassword,
            ));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: 
      BlocListener<WalletBloc, WalletState>(
        listener: (context, state) {
          if (state is WalletLoaded) {
           context.read<WalletBloc>().add(FetchWallet()); 

            Navigator.pop(context);

          } else if (state is WalletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },child: 
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
                child:  Text(
               widget.isEdit ? 'تعديل المحفظة' : 'إنشاء محفظة',
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
widget.isEdit
                              ? '! يرجى إدخال المبلغ الجديد'
                              : '! يرجى إدخال المبلغ وكلمة المرور',                  style: TextStyle(fontSize: 18, color: zeti, fontWeight: FontWeight.bold ,  fontFamily: 'Zain',),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30,),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
               decoration: InputDecoration(
        labelText: 'المبلغ',
        labelStyle: TextStyle(color: zeti),
        prefixIcon: Icon(Icons.attach_money, color: zeti),
        filled: true,
        fillColor: Light_Green.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: zeti, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: babygreen.withOpacity(0.3)),
        ),
      ),
      cursorColor: zeti,
      style: TextStyle(color: zeti),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'يرجى إدخال المبلغ';
                  if (double.tryParse(value) == null) return 'يرجى إدخال رقم صحيح';
                  return null;
                },
              ),
              SizedBox(height: 16),
              if (!widget.isEdit) ...[
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
        labelText: 'كلمة المرور',
        labelStyle: TextStyle(color: zeti),
        prefixIcon: Icon(Icons.password_rounded, color: zeti),
        filled: true,
        fillColor: Light_Green.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: zeti, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: babygreen.withOpacity(0.3)),
        ),
      ),
      cursorColor: zeti,
      style: TextStyle(color: zeti),
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
        labelStyle: TextStyle(color: zeti),
        prefixIcon: Icon(Icons.password, color: zeti),
        filled: true,
        fillColor: Light_Green.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: zeti, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: babygreen.withOpacity(0.3)),
        ),
      ),
      cursorColor: zeti,
      style: TextStyle(color: zeti),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'يرجى تأكيد كلمة المرور';
                  if (value != passwordController.text) return 'كلمات المرور غير متطابقة';
                  return null;
                },
              ),
              SizedBox(height: 30),
              
              ],

              
              SizedBox(
                width: double.infinity,
                child: ElevatedButtonWidget(
  textElevated: widget.isEdit ? 'تحديث' : 'إنشاء',
                              height: 40,
                              width: 30,
                  onPressed: _submit,
                
                 
                ),
              
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}