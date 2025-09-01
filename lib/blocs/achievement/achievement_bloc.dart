import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/services/achievementService.dart';
import 'achievement_event.dart';
import 'achievement_state.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  AchievementBloc() : super(AchievementInitial()) {
    on<LoadAchievement>((event, emit) async {
      emit(AchievementLoading());
      try {
        final summary = await AchievementService.fetchAchievementSummary();
        if (summary != null) {
          emit(AchievementLoaded(summary));
        } else {
          emit(AchievementError('لم يتم العثور على بيانات'));
        }
      } catch (e) {
        emit(AchievementError('حدث خطأ أثناء تحميل البيانات'));
      }
    });
  }
}
