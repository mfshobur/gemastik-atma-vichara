import 'package:atma_vichara_gemastik/feature/domain/entities/goal.dart';

class GoalModel {
  final String id;
  final String title;
  final String description;
  final int date;
  final bool isCompleted;

  GoalModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isCompleted': isCompleted,
    };
  }

  Goal toEntity() {
    return Goal(
      id: id,
      title: title,
      description: description,
      date: DateTime.fromMicrosecondsSinceEpoch(date),
      isCompleted: isCompleted,
    );
  }

  factory GoalModel.fromEntity(Goal entity) {
    return GoalModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      date: entity.date.millisecondsSinceEpoch,
      isCompleted: entity.isCompleted,
    );
  }
}
