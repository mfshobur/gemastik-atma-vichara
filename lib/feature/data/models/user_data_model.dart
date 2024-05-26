import 'package:atma_vichara_gemastik/feature/domain/entities/user_data.dart';

class UserDataModel {
  final String name;
  final String email;

  UserDataModel({
    required this.name,
    required this.email,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  UserData toEntity() {
    return UserData(
      name: name,
      email: email,
    );
  }

  factory UserDataModel.fromEntity(UserData entity) {
    return UserDataModel(
      name: entity.name,
      email: entity.email,
    );
  }
}
