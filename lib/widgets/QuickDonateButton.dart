import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';


class GlobalDonationFab extends StatelessWidget {
  const GlobalDonationFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60, 
      height: 60, 
      margin: EdgeInsets.only(left: 16, bottom: 70),
      child: FloatingActionButton(
        heroTag: "global_donation_fab",
        backgroundColor: Color.fromARGB(255, 247, 119, 134),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              TextEditingController amountController = TextEditingController();
              TextEditingController walletPasswordController =
                  TextEditingController();

              return StatefulBuilder(
                builder: (context, setState) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 247, 119, 134),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          "تبرع سريع",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: zeti,
                            fontFamily: 'Zain',
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          "سيذهب تبرعك تلقائيًا لأحد الحالات الطارئة",
                          style: TextStyle(
                            fontSize: 14,
                            color: medium_Green,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Zain',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: amountController,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'أدخل المبلغ',
                          filled: true,
                          fillColor: babygreen.withOpacity(0.3),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: zeti, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: babygreen.withOpacity(0.3)),
                          ),
                        ),
                        cursorColor: zeti,
                        style: TextStyle(
                          color: zeti,
                          fontFamily: 'Zain',
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: walletPasswordController,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'أدخل كلمة سر المحفظة',
                          filled: true,
                          fillColor: babygreen.withOpacity(0.3),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: zeti, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: babygreen.withOpacity(0.3)),
                          ),
                        ),
                        cursorColor: zeti,
                        style: TextStyle(
                          color: zeti,
                          fontFamily: 'Zain',
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (amountController.text.isEmpty ||
                              walletPasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "يرجى تعبئة المبلغ وكلمة سر المحفظة",
                                  style: TextStyle(fontFamily: 'Zain'),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 247, 119, 134),
                              ),
                            );
                            return;
                          }
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "تم التبرع بمبلغ ${amountController.text} ",
                                style: TextStyle(fontFamily: 'Zain'),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 247, 119, 134),
                            ),
                          );
                        },
                        child: Text(
                          "تم",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Zain',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: medium_Green,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.volunteer_activism, color: Colors.white , size: 35,),
      ),
    );
  }
}
