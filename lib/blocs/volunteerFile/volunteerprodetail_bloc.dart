import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerprodetail_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerprodetail_state.dart' show VolunteerProfileDetailError, VolunteerProfileDetailInitial, VolunteerProfileDetailLoaded, VolunteerProfileDetailLoading, VolunteerProfileDetailState, VolunteerProfileUpdateError, VolunteerProfileUpdateLoading, VolunteerProfileUpdateSuccess;
import 'package:hello/services/volunteerProfileForm_service.dart';

class VolunteerProfileDetailBloc
    extends Bloc<VolunteerProfileDetailEvent, VolunteerProfileDetailState> {
  final VolunteerService service;

  VolunteerProfileDetailBloc(this.service)
      : super(VolunteerProfileDetailInitial()) {
    on<FetchVolunteerDetailProfile>(_onFetchVolunteerDetailProfile);
        on<UpdateVolunteerDetailProfile>(_onUpdateVolunteerDetailProfile);

  }

  Future<void> _onFetchVolunteerDetailProfile(
    FetchVolunteerDetailProfile event,
    Emitter<VolunteerProfileDetailState> emit,
  ) async {
    emit(VolunteerProfileDetailLoading());
    try {
      final response = await service.getVolunteerDetailProfile();
          print("✅ Parsed model: ${response.data}"); // Debug

      emit(VolunteerProfileDetailLoaded(response.data)); // ✅ model مظبوط
    } catch (e) {
          print("❌ Error in Bloc: $e"); // Debug

      emit(VolunteerProfileDetailError(e.toString()));
    }
  }
Future<void> _onUpdateVolunteerDetailProfile(
    UpdateVolunteerDetailProfile event,
    Emitter<VolunteerProfileDetailState> emit,
  ) async {
    emit(VolunteerProfileUpdateLoading());
    try {
      final response = await service.updateVolunteerProfile(event.updatedData);
      print("✅ Update response model: ${response.data}"); // Debug
      emit(VolunteerProfileUpdateSuccess(response.message));

      // ✅ بعد التحديث، جلب البيانات المحدثة
      add(FetchVolunteerDetailProfile());
    } catch (e) {
      print("❌ Update error: $e"); // Debug
      emit(VolunteerProfileUpdateError(e.toString()));
    }
  }

  
}
