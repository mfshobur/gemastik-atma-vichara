import 'package:atma_vichara_gemastik/feature/domain/entities/user_data.dart';

class UserDataModel {
  final String id;
  final String name;
  final String email;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  UserData toEntity() {
    return UserData(
      id: id,
      name: name,
      email: email,
    );
  }

  factory UserDataModel.fromEntity(UserData entity) {
    return UserDataModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
    );
  }
}
