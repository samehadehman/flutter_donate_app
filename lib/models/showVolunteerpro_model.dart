class GetVolunteerProfileResponse {
  final int status;
  final VolunteerProfileView data;
  final String message;

  GetVolunteerProfileResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GetVolunteerProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetVolunteerProfileResponse(
      status: json['status'],
      data: VolunteerProfileView.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class VolunteerProfileView {
  final String volunteerName;
  final String timeBecomingVolunteerMember;

  VolunteerProfileView({
    required this.volunteerName,
    required this.timeBecomingVolunteerMember,
  });

  factory VolunteerProfileView.fromJson(Map<String, dynamic> json) {
    return VolunteerProfileView(
      volunteerName: json['volunteer_name'],
      timeBecomingVolunteerMember: json['time_becoming_volunteer_member'],
    );
  }
}
