import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_state.dart';
import 'package:hello/models/createvolunteerpro_model.dart';
import 'package:hello/models/showVolunteerpro_model.dart';
import 'package:hello/services/userProfile_service.dart';
import 'package:hello/services/volunteerProfileForm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class VolunteerProfileBloc extends Bloc<VolunteerProfileEvent, VolunteerProfileState> {
  final VolunteerService service;
  VolunteerProfileBloc(this.service) : super(VolunteerProfileInitial()) {
    on<CreateVolunteerProfileEvent>(_onCreate);
    on<UpdateVolunteerProfileEvent>(_onUpdate);
    on<GetVolunteerProfileEvent>(_onGet);
        on<GetVolunteerDetailProfileEvent>(_onGetDetail);
  }

  Future<void> _onCreate(CreateVolunteerProfileEvent e, Emitter emit) async {
    emit(VolunteerProfileLoading());
    try {
      final res = await service.createProfile(e.model.toJson());
      emit(VolunteerProfileSuccess(res.data)); // Model
       add(GetVolunteerProfileEvent()); // ✅ إعادة تحميل الملف الجديد
    } catch (err) {
      emit(VolunteerProfileError(err.toString()));
    }
  }

  Future<void> _onUpdate(UpdateVolunteerProfileEvent e, Emitter emit) async {
    emit(VolunteerProfileLoading());
    try {
      final res = await service.updateProfile(e.model.toJson());
      emit(VolunteerProfileSuccess(res.data)); // Model
       add(GetVolunteerProfileEvent()); // ✅ إعادة تحميل الملف الجديد
    } catch (err) {
      emit(VolunteerProfileError(err.toString()));
    }
  }

  Future<void> _onGet(GetVolunteerProfileEvent e, Emitter emit) async {
    emit(VolunteerProfileLoading());
    try {
      final res = await service.getProfile();
      // ✅ هون بنرجّع حالة العرض الجديدة
      emit(VolunteerProfileViewSuccess(res.data)); 
    } catch (err) {
      emit(VolunteerProfileError(err.toString()));
    }
  }

  
  // === تحميل الملف للتفاصيل مباشرة ===
Future<void> _onGetDetail(GetVolunteerDetailProfileEvent e, Emitter emit) async {
    emit(VolunteerProfileLoading());
    try {
      final res = await service.getVolunteerDetailProfile(); // endpoint للتفاصيل
      emit(VolunteerProfileDetailsLoaded(res.data));
    } catch (err) {
      emit(VolunteerProfileError(err.toString()));
    }
  }
}





































// class VolunteerProfileBloc extends Bloc<VolunteerProfileEvent, VolunteerProfileState> {
//   final VolunteerService service;
//   final UserService userService;

//   VolunteerProfileBloc(this.service, this.userService)
//       : super(VolunteerProfileInitial()) {
//     on<CreateVolunteerProfileEvent>(_onCreateProfile);
//     on<GetVolunteerProfileEvent>(_onGetProfile);
//     on<LoadUserNameEvent>(_onLoadUserName);
//     on<UpdateVolunteerProfileEvent>(_onUpdateProfile); // ✅ التعديل

//   }


//   Future<void> _onLoadUserName(
//       LoadUserNameEvent event, Emitter<VolunteerProfileState> emit) async {
//     emit(VolunteerProfileLoading());
//     try {
//       final user = await userService.fetchUserProfile();
//       emit(VolunteerProfileLoaded(
//           VolunteerProfileModel.fromJson({}), // 🔹 dummy فاضي
//           userName: user.name));
//     } catch (e) {
//       emit(VolunteerProfileError(e.toString()));
//     }
//   }

//   Future<void> _onCreateProfile(
//       CreateVolunteerProfileEvent event, Emitter<VolunteerProfileState> emit) async {
//     emit(VolunteerProfileLoading());
//     try {
//       print("📤 Sending profile JSON: ${jsonEncode(event.model.toJson())}");

//       final res = await service.createProfile(event.model.toJson());

//       // هون res.data من نوع VolunteerProfileModel
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(
//           'volunteer_profile_create', jsonEncode(res.data.toJson()));

//       emit(VolunteerProfileSuccess(res.data)); // ✅ بيرجع VolunteerProfileModel
//     } catch (e , stackTrace) {
//        print("🚨 VolunteerProfileBloc Create Error: $e");
//     print(stackTrace);
//       emit(VolunteerProfileError(e.toString()));
//     }
//   }

//   Future<void> _onGetProfile(
//       GetVolunteerProfileEvent event, Emitter<VolunteerProfileState> emit) async {
//     emit(VolunteerProfileLoading());
//     try {
//       final prefs = await SharedPreferences.getInstance();

//       // ✅ أول شي حاول تجيب نسخة محلية من العرض (VolunteerProfileView)
//       final cached = prefs.getString('volunteer_profile_view');
//       if (cached != null) {
//         final data = VolunteerProfileView.fromJson(jsonDecode(cached));
//         emit(VolunteerProfileViewSuccess(data));
//       }

//       // ✅ بعدين جب نسخة محدثة من السيرفر
//       final res = await service.getProfile();
//       await prefs.setString(
//           'volunteer_profile_view', jsonEncode(res.data.toJson()));

//       emit(VolunteerProfileViewSuccess(res.data)); // ✅ بيرجع VolunteerProfileView
//     } catch (e , stackTrace) {
//        print("🚨 VolunteerProfileBloc Geet Error: $e");
//     print(stackTrace);
//       emit(VolunteerProfileError(e.toString()));
//     }
//   }


//   Future<void> _onUpdateProfile(
//       UpdateVolunteerProfileEvent event, Emitter<VolunteerProfileState> emit) async {
//     emit(VolunteerProfileLoading());
//     try {
//       print("✏️ Updating profile JSON: ${jsonEncode(event.model.toJson())}");

//       final res = await service.updateVolunteerProfile(event.model.toJson());

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(
//         'volunteer_profile_view',
//         jsonEncode(res.data.toJson()),
//       );

//       emit(VolunteerProfileSuccess(res.data)); // ✅ VolunteerProfileModel بعد التعديل
//     } catch (e, stackTrace) {
//       print("🚨 VolunteerProfileBloc Update Error: $e");
//       print(stackTrace);
//       emit(VolunteerProfileError(e.toString()));
//     }
//   }
// }

// class VolunteerProfileUpdateBloc
//     extends Bloc<VolunteerProfileUpdateEvent, VolunteerProfileUpdateState> {
//   VolunteerProfileUpdateBloc() : super(VolunteerProfileUpdateInitial()) {
//     on<UpdateVolunteerProfileEvent>((event, emit) async {
//       emit(VolunteerProfileUpdateLoading());
//       try {
//         // 🔄 نداء للسيرفس تبعك هون
//         await Future.delayed(const Duration(seconds: 2)); // simulation
//         emit(VolunteerProfileUpdateSuccess());
//       } catch (e) {
//         emit(VolunteerProfileUpdateError("فشل التحديث: $e"));
//       }
//     });
//   }
// }
