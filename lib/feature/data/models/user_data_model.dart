import 'package:atma_vichara_gemastik/feature/domain/entities/user_data.dart';

class UserDataModel {
  final String id;
  final String name;
  final String email;
  final bool alreadyReflectPast;
  final bool alreadyReflectPresent;
  final bool alreadyReflectFuture;
  final List<String>? pastAnswers;
  final List<String>? presentAnswers;
  final List<String>? futureAnswers;
  final String? reflectionResponse;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.alreadyReflectPast,
    required this.alreadyReflectPresent,
    required this.alreadyReflectFuture,
    required this.pastAnswers,
    required this.presentAnswers,
    required this.futureAnswers,
    this.reflectionResponse,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      alreadyReflectPast: json['already_reflect_past'],
      alreadyReflectPresent: json['already_reflect_present'],
      alreadyReflectFuture: json['already_reflect_future'],
      pastAnswers: json['past_answers'] != null ? List<String>.from(json['past_answers']) : null,
      presentAnswers:
          json['present_answers'] != null ? List<String>.from(json['present_answers']) : null,
      futureAnswers:
          json['future_answers'] != null ? List<String>.from(json['future_answers']) : null,
          reflectionResponse: json['reflection_response'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'already_reflect_past': alreadyReflectPast,
      'already_reflect_present': alreadyReflectPresent,
      'already_reflect_future': alreadyReflectFuture,
      'past_answers': pastAnswers,
      'present_answers': presentAnswers,
      'future_answers': futureAnswers,
      'reflection_response': reflectionResponse,
    };
  }

  UserData toEntity() {
    return UserData(
      id: id,
      name: name,
      email: email,
      alreadyReflectPast: alreadyReflectPast,
      alreadyReflectPresent: alreadyReflectPresent,
      alreadyReflectFuture: alreadyReflectFuture,
      pastAnswers: pastAnswers,
      presentAnswers: presentAnswers,
      futureAnswers: futureAnswers,
      reflectionResponse: reflectionResponse,
    );
  }

  factory UserDataModel.fromEntity(UserData entity) {
    return UserDataModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      alreadyReflectPast: entity.alreadyReflectPast,
      alreadyReflectPresent: entity.alreadyReflectPresent,
      alreadyReflectFuture: entity.alreadyReflectFuture,
      pastAnswers: entity.pastAnswers,
      presentAnswers: entity.presentAnswers,
      futureAnswers: entity.futureAnswers,
      reflectionResponse: entity.reflectionResponse,
    );
  }
}
