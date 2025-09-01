import 'package:flutter/material.dart';
import 'package:hello/core/color.dart';

class CaseFormPage extends StatefulWidget {
  @override
  State<CaseFormPage> createState() => _CaseFormPageState();
}

class _CaseFormPageState extends State<CaseFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController supervisorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController beneficiariesController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? selectedTitleType;
  String? selectedTargetGroup;
  double urgencyLevel = 3;
  bool hasSupporters = false;

  Map<String, bool> needs = {'بيئي': false, 'صحي': false, 'تعليمي': false};

  Map<String, bool> recommendations = {
    'أوصي بالموافقة': false,
    'أوصي بالرفض': false,
    'مراجعة الحالة': false,
  };

  List<String> titleTypes = ['حالة اجتماعية', 'طلب دعم عاجل', 'طلب علاج طبي'];
  List<String> targetGroups = [
    'الأطفال',
    'النساء',
    'ذوي الاحتياجات الخاصة',
    'العائلات المتضررة',
  ];

  Future<void> pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2040),
    );
    if (selected != null) {
      setState(() {
        dateController.text = "${selected.toLocal()}".split(' ')[0];
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // هنا ممكن ترسل البيانات للسيرفر أو تخزنها
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إرسال البيانات بنجاح!'),
          backgroundColor: Color.fromARGB(255, 247, 119, 134),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0XFF4B4D40),
                  Color.fromARGB(255, 115, 123, 114),
                  Color(0xFFb3beb0),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
            alignment: Alignment.center,
            child: Image.asset('assets/images/logo2.png', height: 60, width: 60),
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
                icon: Icon(Icons.arrow_forward_ios, color: Color(0XFFF2F4EC)),
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
                'نموذج تقييم الحالة',
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
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: babygreen.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -15),
                  ),
                ],
                border: Border(top: BorderSide(color: zeti, width: 2)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
                ),
                color: Color(0XFFF2F4EC),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildTextField(
                          'التاريخ',
                          dateController,
                          Icons.date_range,
                          onTap: pickDate,
                          readOnly: true,
                        ),
                        buildTextField(
                          'اسم المشرف',
                          supervisorController,
                          Icons.person,
                        ),
                        buildDropdown(
                          'نوع العنوان',
                          titleTypes,
                          selectedTitleType,
                          Icons.title,
                          (val) => setState(() => selectedTitleType = val),
                        ),
                        buildMultilineField(
                          'وصف الحالة',
                          descriptionController,
                          Icons.description,
                        ),
                        buildTextField(
                          'عدد المستفيدين',
                          beneficiariesController,
                          Icons.people,
                          keyboardType: TextInputType.number,
                        ),
                        buildDropdown(
                          'الفئة المستهدفة',
                          targetGroups,
                          selectedTargetGroup,
                          Icons.group,
                          (val) => setState(() => selectedTargetGroup = val),
                        ),

                        // نوع الاحتياجات
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            textDirection: TextDirection.rtl,

                            'نوع الاحتياج:',
                            style: TextStyle(fontWeight: FontWeight.bold ,  fontFamily: 'Zain',),
                            selectionColor: babygreen,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              needs.keys.map((key) {
                                return Expanded(
                                  child: CheckboxListTile(
                                    activeColor: const Color.fromARGB(
                                      255,
                                      247,
                                      215,
                                      119,
                                    ),
                                    title: Text(key),
                                    value: needs[key],
                                    onChanged: (val) {
                                      setState(() {
                                        needs[key] = val!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 20),

                        // جهات داعمة
                        CheckboxListTile(
                          activeColor: const Color.fromARGB(255, 247, 215, 119),
                          value: hasSupporters,
                          onChanged:
                              (val) => setState(() => hasSupporters = val!),
                          title: Text(
                            textDirection: TextDirection.rtl,

                            'هل يوجد جهات داعمة أخرى؟',
                            style: TextStyle(color: zeti),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        const SizedBox(height: 20),
                        // درجة الطارئة
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                textDirection: TextDirection.rtl,
                                'تقييم احتياج الحالة (${urgencyLevel.toInt()} / 5)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: zeti,
                                   fontFamily: 'Zain',
                                ),
                              ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Color.fromARGB(
                                  255,
                                  247,
                                  119,
                                  134,
                                ), // أو Colors.amber للأصفر
                                thumbColor: Color.fromARGB(
                                  255,
                                  247,
                                  119,
                                  134,
                                ), // المقبض
                                inactiveTrackColor: Light_Green,
                              ),
                              child: Slider(
                                value: urgencyLevel,
                                min: 1,
                                max: 5,
                                divisions: 4,
                                onChanged:
                                    (val) => setState(() => urgencyLevel = val),
                              ),
                            ),
                          ],
                        ),

                        buildMultilineField(
                          'ملاحظات',
                          notesController,
                          Icons.note_alt,
                        ),

                        // توصية
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.topRight,

                          child: Text(
                            textDirection: TextDirection.rtl,

                            'التوصية:',
                            style: TextStyle(fontWeight: FontWeight.bold ,  fontFamily: 'Zain',) ,
                            selectionColor: zeti,
                          ),
                        ),
                        Row(
                          children:
                              recommendations.keys.map((key) {
                                return Expanded(
                                  child: CheckboxListTile(
                                    //
                                    activeColor: const Color.fromARGB(
                                      255,
                                      247,
                                      215,
                                      119,
                                    ),
                                    title: Text(
                                      key,
                                      style: TextStyle(fontSize: 15 ,  fontFamily: 'Zain',),
                                    ),
                                    value: recommendations[key],
                                    onChanged: (val) {
                                      setState(() {
                                        recommendations[key] = val!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                );
                              }).toList(),
                        ),

                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: medium_Green,
                              foregroundColor: white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _submit,
                            child: Text('إرسال النموذج'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    VoidCallback? onTap,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: zeti),
          prefixIcon: Icon(icon, color: medium_Green),
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
        validator:
            (val) => (val == null || val.isEmpty) ? 'هذا الحقل مطلوب' : null,
        style: TextStyle(color: zeti),
        cursorColor: zeti,
      ),
    );
  }

  Widget buildMultilineField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return buildTextField(
      label,
      controller,
      icon,
      keyboardType: TextInputType.multiline,
    );
  }

  Widget buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    IconData icon,
    Function(String?) onChanged,
  ) {
    if (selectedValue != null && !items.contains(selectedValue)) {
      selectedValue = null;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: zeti),
          prefixIcon: Icon(icon, color: medium_Green),
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
          suffixIcon: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              alignment: Alignment.topRight,
              value: selectedValue,
              icon: Icon(Icons.arrow_drop_down, color: zeti),
              onChanged: onChanged,
              items:
                  items
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: SizedBox(
                            width:
                                MediaQuery.of(context).size.width *
                                0.3, // نصف عرض الشاشة
                            // 🔹 عرض القائمة المنسدلة
                            child: Text(
                              textDirection: TextDirection.rtl,

                              item,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
