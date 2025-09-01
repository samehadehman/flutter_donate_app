import 'package:hello/models/achievementSummary.dart';

abstract class AchievementState {}

class AchievementInitial extends AchievementState {}

class AchievementLoading extends AchievementState {}

class AchievementLoaded extends AchievementState {
  final AchievementSummary summary;

  AchievementLoaded(this.summary);
}

class AchievementError extends AchievementState {
  final String message;

  AchievementError(this.message);
}
