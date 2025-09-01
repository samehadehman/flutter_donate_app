class CreateVolunteerProfileResponse {
  final int status;
  final VolunteerProfileModel data;
  final String message;

  CreateVolunteerProfileResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory CreateVolunteerProfileResponse.fromJson(Map<String, dynamic> json) {
    return CreateVolunteerProfileResponse(
      status: json['status'],
      data: VolunteerProfileModel.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class VolunteerProfileModel {
  final AvailabilityType availabilityType;
  final String skills;
  final String availabilityHours;
  final String preferredTasks;
  final String academicMajor;
  final String previousVolunteerWork;

  VolunteerProfileModel({
    required this.availabilityType,
    required this.skills,
    required this.availabilityHours,
    required this.preferredTasks,
    required this.academicMajor,
    required this.previousVolunteerWork,
  });

  factory VolunteerProfileModel.fromJson(Map<String, dynamic> json) {
    return VolunteerProfileModel(
      availabilityType: AvailabilityType.fromJson(json['availability_type_id']),
      skills: json['skills'],
      availabilityHours: json['availability_hours'],
      preferredTasks: json['preferred_tasks'],
      academicMajor: json['academic_major'],
      previousVolunteerWork: json['previous_volunteer_work'],
    );
  }
    Map<String, dynamic> toJson() {
    return {
      "availability_type_id": availabilityType.id,
      "skills": skills,
      "availability_hours": availabilityHours,
      "preferred_tasks": preferredTasks,
      "academic_major": academicMajor,
      "previous_volunteer_work": previousVolunteerWork,
    };
  }
}

class AvailabilityType {
  final String id;
  final String availabilityType;

  AvailabilityType({
    required this.id,
    required this.availabilityType,
  });

  factory AvailabilityType.fromJson(Map<String, dynamic> json) {
    return AvailabilityType(
      id: json['id'],
      availabilityType: json['availability_type'],
    );
  }
}
