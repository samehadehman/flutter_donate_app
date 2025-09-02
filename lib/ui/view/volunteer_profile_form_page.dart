import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/models/createvolunteerpro_model.dart';


class VolunteerProfileFormPage extends StatefulWidget {

  
  const VolunteerProfileFormPage({super.key});

  @override
  State<VolunteerProfileFormPage> createState() =>
      _VolunteerProfileFormPageState();
}

class _VolunteerProfileFormPageState extends State<VolunteerProfileFormPage> {
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController interestsController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController pastVolunteerController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> availabilityOptions = ['يوميًا', 'أسبوعيًا'];
  String? selectedAvailability;
  VolunteerProfileModel? _currentModel;

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // بناء الموديل
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

    // تأكيد البيانات
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: babygreen,
        content: Text(
          'هل أنت متأكد من معلوماتك؟',
          textAlign: TextAlign.center,
          style: TextStyle(color: zeti),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: zeti),
            onPressed: () => Navigator.pop(context, false),
            child: const Text('تعديل', style: TextStyle(fontFamily: 'Zain')),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: zeti),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'نعم',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Zain',
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // إرسال الحدث للـ Bloc
    context.read<VolunteerProfileBloc>().add(
          CreateVolunteerProfileEvent(_currentModel!),
        );
  }

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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      icon: const Icon(Icons.arrow_forward_ios, color: Color(0XFFF2F4EC)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -30)),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: BlocConsumer<VolunteerProfileBloc, VolunteerProfileState>(
                listener: (context, state) async {
                  if (state is VolunteerProfileSuccess && _currentModel != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        Navigator.pop(context, _currentModel); // ⬅️ ارجع الموديل
                      }
                    });
                  } else if (state is VolunteerProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
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
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/logo.png'),
                          ),
                          const SizedBox(height: 30),
                          _buildTextField("المهارات", skillsController, Icons.star),
                          const SizedBox(height: 16),
                          _buildAvailabilityDropdown(),
                          const SizedBox(height: 16),
                          if (selectedAvailability == 'يوميًا' ||
                              selectedAvailability == 'أسبوعيًا') ...[
                            _buildTextField("عدد الساعات المتاحة", hoursController, Icons.timelapse),
                            const SizedBox(height: 16),
                          ],
                          _buildTextField("الأعمال المفضلة", interestsController, Icons.favorite),
                          const SizedBox(height: 16),
                          _buildTextField("التخصص الأكاديمي", majorController, Icons.school),
                          const SizedBox(height: 16),
                          _buildTextField("أعمال تطوعية سابقة", pastVolunteerController, Icons.history),
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
                            label: const Text(
                              "تأكيد المعلومات",
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Zain'),
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

  Widget _buildAvailabilityDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedAvailability,
      items: availabilityOptions
          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedAvailability = value;
          if (selectedAvailability != 'يوميًا' && selectedAvailability != 'أسبوعيًا') {
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
      dropdownColor: Colors.white,
      iconEnabledColor: zeti,
    );
  }
}
