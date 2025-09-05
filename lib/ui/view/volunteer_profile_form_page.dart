import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/models/createvolunteerpro_model.dart';
import 'package:hello/widgets/elevatedButton.dart';




class VolunteerProfileFormPage extends StatefulWidget {
    static String id = "form";

  final VolunteerProfileModel? existingProfile; // null = إنشاء, موجود = تعديل

  const VolunteerProfileFormPage({super.key, this.existingProfile});

  @override
  State<VolunteerProfileFormPage> createState() => _VolunteerProfileFormPageState();
}

class _VolunteerProfileFormPageState extends State<VolunteerProfileFormPage> {
  final _formKey = GlobalKey<FormState>();

  final skillsController = TextEditingController();
  final interestsController = TextEditingController();
  final majorController = TextEditingController();
  final pastVolunteerController = TextEditingController();
  final hoursController = TextEditingController();

  final List<String> availabilityOptions = ['يوميًا', 'أسبوعيًا'];
  String? selectedAvailability;

  VolunteerProfileModel? _currentModel;

  @override
  void initState() {
    super.initState();
    if (widget.existingProfile != null) {
      final p = widget.existingProfile!;

      skillsController.text = p.skills ?? "";
      interestsController.text = p.preferredTasks ?? "";
      majorController.text = p.academicMajor ?? "";
      pastVolunteerController.text = p.previousVolunteerWork ?? "";
      hoursController.text = p.availabilityHours ?? "";

      // ✅ تأكد من قيمة dropdown
      if (p.availabilityType != null &&
          availabilityOptions.contains(p.availabilityType.availabilityType)) {
        selectedAvailability = p.availabilityType.availabilityType;
      } else {
        selectedAvailability = null;
      }
    }
  }

  @override
  void dispose() {
    skillsController.dispose();
    interestsController.dispose();
    majorController.dispose();
    pastVolunteerController.dispose();
    hoursController.dispose();
    super.dispose();
  }

  int _availabilityTypeId(String? arLabel) {
    if (arLabel == 'يوميًا') return 1;
    if (arLabel == 'أسبوعيًا') return 2;
    return 0;
  }

  bool showHoursField() {
    return selectedAvailability != null &&
        (selectedAvailability == 'يوميًا' || selectedAvailability == 'أسبوعيًا');
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _currentModel = VolunteerProfileModel(
      availabilityType: AvailabilityType(
        id: _availabilityTypeId(selectedAvailability).toString(),
        availabilityType: selectedAvailability ?? "",
      ),
      skills: skillsController.text,
      availabilityHours: hoursController.text,
      preferredTasks: interestsController.text,
      academicMajor: majorController.text,
      previousVolunteerWork: pastVolunteerController.text,
    );

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0XFFF2F4EC),
        content: Text(
          'هل أنت متأكد من معلوماتك؟',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 115, 123, 114),
            fontWeight: FontWeight.w600,
            fontFamily: 'Zain',
          ),
        ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,

                actions: [
          TextButton(
                        style: TextButton.styleFrom(foregroundColor: zeti),

            onPressed: () => Navigator.pop(context, false), child: const Text("تعديل" ,  style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 247, 119, 134),
                fontWeight: FontWeight.w600,
                fontFamily: 'Zain',
              ),
            ),
          ),
           ElevatedButtonWidget(
            textElevated: 'نعم',
            height: 35,
            width: 70,
            onPressed: ()  => Navigator.pop(context, true), ),
                ]
      ),
    );

    if (confirm != true) return;

    if (widget.existingProfile == null) {
      context.read<VolunteerProfileBloc>().add(CreateVolunteerProfileEvent(_currentModel!));
    } else {
      context.read<VolunteerProfileBloc>().add(UpdateVolunteerProfileEvent(_currentModel!));
    }
  }

@override
Widget build(BuildContext context) {
  return  Container(
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
  child: Scaffold(
    backgroundColor: Colors.transparent,
    body: Column(
      children: [
        // 🔹 الهيدر
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0X80D9E4D7).withAlpha(85),
                    borderRadius: BorderRadius.circular(90),
                    border: Border.all(color: const Color(0XFFF2F4EC)),
                  ),
                  child: const Text(
                    'ملف التطوع',
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
                    border: Border.all(color: const Color(0XFFF2F4EC)),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Color(0XFFF2F4EC)),
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
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -10)),
              ],
              color: const Color.fromARGB(255, 252, 248, 241),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(70),
                topRight: Radius.circular(70),
              ),
            ),
            child: BlocConsumer<VolunteerProfileBloc, VolunteerProfileState>(
              listener: (context, state) {
                if (state is VolunteerProfileSuccess ||
                    state is VolunteerProfileViewSuccess) {
                  Navigator.pop(
                    context,
                    state is VolunteerProfileSuccess
                        ? state.profile
                        : (state as VolunteerProfileViewSuccess).profile,
                  );
                } else if (state is VolunteerProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final isLoading = state is VolunteerProfileLoading;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        const CircleAvatar(
                          radius: 56,
                          backgroundColor:
                              Color.fromARGB(255, 252, 248, 241),
                          backgroundImage:
                              AssetImage('assets/images/logo.png'),
                        ),
                        const SizedBox(height: 30),
                        _buildTextField("المهارات", skillsController, Icons.star),
                        const SizedBox(height: 16),
                        _buildAvailabilityDropdown(),
                        const SizedBox(height: 16),
                        if (showHoursField()) ...[
                          _buildTextField("عدد الساعات المتاحة", hoursController,
                              Icons.timelapse),
                          const SizedBox(height: 16),
                        ],
                        _buildTextField("الأعمال المفضلة", interestsController,
                            Icons.favorite),
                        const SizedBox(height: 16),
                        _buildTextField("التخصص الأكاديمي", majorController,
                            Icons.school),
                        const SizedBox(height: 16),
                        _buildTextField("أعمال تطوعية سابقة",
                            pastVolunteerController, Icons.history),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: medium_Green,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          icon: const Icon(Icons.check_circle),
                          label: Text(
                            widget.existingProfile == null
                                ? "حفظ الملف"
                                : "تحديث الملف",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Zain',
                            ),
                          ),
                          onPressed: isLoading ? null : _submit,
                        ),
                        if (isLoading)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  ),
);
}

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(icon, color: zeti),
        filled: true,
        fillColor: babygreen.withOpacity(0.3),
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
      validator: (value) => (value == null || value.isEmpty) ? 'الرجاء تعبئة هذا الحقل' : null,
    );
  }


  // Widget _buildAvailabilityDropdown() {
  //   return DropdownButtonFormField<String>(
  //     value: selectedAvailability != null &&
  //             availabilityOptions.contains(selectedAvailability)
  //         ? selectedAvailability
  //         : null,
  //     items: availabilityOptions
  //         .map((e) => DropdownMenuItem(value: e, child: Text(e)))
  //         .toList(),
  //     onChanged: (v) => setState(() => selectedAvailability = v),
  //     decoration: const InputDecoration(
  //       labelText: "أوقات التفرغ",
  //       border: OutlineInputBorder(),
  //     ),
  //     validator: (v) => v == null ? "الرجاء اختيار وقت التفرغ" : null,
  //   );
  // }

  Widget _buildAvailabilityDropdown() {
  return DropdownButtonFormField<String>(
    value: selectedAvailability != null &&
            availabilityOptions.contains(selectedAvailability)
        ? selectedAvailability
        : null,
    items: availabilityOptions
        .map((option) => DropdownMenuItem(
              value: option,
              child: Text(option),
            ))
        .toList(),
    onChanged: (value) {
      setState(() {
        selectedAvailability = value;
        if (selectedAvailability != 'يوميًا' &&
            selectedAvailability != 'أسبوعيًا') {
          hoursController.clear();
        }
      });
    },
    decoration: InputDecoration(
      labelText: "أوقات التفرغ",
      labelStyle: const TextStyle(color: Colors.black),
      prefixIcon: Icon(Icons.access_time, color: zeti),
      filled: true,
      fillColor: babygreen.withOpacity(0.3),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: zeti, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: babygreen.withOpacity(0.3)),
      ),
    ),
    validator: (v) => v == null ? "الرجاء اختيار وقت التفرغ" : null,
    dropdownColor: Colors.white,
    iconEnabledColor: zeti,
  );
}

}