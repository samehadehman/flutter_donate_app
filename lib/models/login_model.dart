// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    int status;
    Data data;
    String message;

    LoginModel({
        required this.status,
        required this.data,
        required this.message,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    int id;
    int roleId;
    String name;
    String email;
    String phone;
    dynamic cityId;
    dynamic age;
    String photo;
    int points;
    dynamic genderId;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    Roles roles;
    List<Permission> permissions;
    String token;

    Data({
        required this.id,
        required this.roleId,
        required this.name,
        required this.email,
        required this.phone,
        required this.cityId,
        required this.age,
        required this.photo,
        required this.points,
        required this.genderId,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.roles,
        required this.permissions,
        required this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        cityId: json["city_id"],
        age: json["age"],
        photo: json["photo"],
        points: json["points"],
        genderId: json["gender_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        roles: Roles.fromJson(json["roles"]),
        permissions: List<Permission>.from(json["permissions"].map((x) => Permission.fromJson(x))),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "phone": phone,
        "city_id": cityId,
        "age": age,
        "photo": photo,
        "points": points,
        "gender_id": genderId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "roles": roles.toJson(),
        "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
        "token": token,
    };
}

class Permission {
    int id;
    String name;
    GuardName guardName;
    DateTime createdAt;
    DateTime updatedAt;
    PermissionPivot pivot;

    Permission({
        required this.id,
        required this.name,
        required this.guardName,
        required this.createdAt,
        required this.updatedAt,
        required this.pivot,
    });

    factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        name: json["name"],
        guardName: guardNameValues.map[json["guard_name"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: PermissionPivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardNameValues.reverse[guardName],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
    };
}

enum GuardName {
    WEB
}

final guardNameValues = EnumValues({
    "web": GuardName.WEB
});

class PermissionPivot {
    ModelType modelType;
    int modelId;
    int permissionId;

    PermissionPivot({
        required this.modelType,
        required this.modelId,
        required this.permissionId,
    });

    factory PermissionPivot.fromJson(Map<String, dynamic> json) => PermissionPivot(
        modelType: modelTypeValues.map[json["model_type"]]!,
        modelId: json["model_id"],
        permissionId: json["permission_id"],
    );

    Map<String, dynamic> toJson() => {
        "model_type": modelTypeValues.reverse[modelType],
        "model_id": modelId,
        "permission_id": permissionId,
    };
}

enum ModelType {
    APP_MODELS_USER
}

final modelTypeValues = EnumValues({
    "App\\Models\\User": ModelType.APP_MODELS_USER
});

class Roles {
    int id;
    String name;
    GuardName guardName;
    DateTime createdAt;
    DateTime updatedAt;
    RolesPivot pivot;

    Roles({
        required this.id,
        required this.name,
        required this.guardName,
        required this.createdAt,
        required this.updatedAt,
        required this.pivot,
    });

    factory Roles.fromJson(Map<String, dynamic> json) => Roles(
        id: json["id"],
        name: json["name"],
        guardName: guardNameValues.map[json["guard_name"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: RolesPivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardNameValues.reverse[guardName],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
    };
}

class RolesPivot {
    ModelType modelType;
    int modelId;
    int roleId;

    RolesPivot({
        required this.modelType,
        required this.modelId,
        required this.roleId,
    });

    factory RolesPivot.fromJson(Map<String, dynamic> json) => RolesPivot(
        modelType: modelTypeValues.map[json["model_type"]]!,
        modelId: json["model_id"],
        roleId: json["role_id"],
    );

    Map<String, dynamic> toJson() => {
        "model_type": modelTypeValues.reverse[modelType],
        "model_id": modelId,
        "role_id": roleId,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}