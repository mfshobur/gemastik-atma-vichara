import 'package:atma_vichara_gemastik/feature/domain/entities/daily_note.dart';

class DailyNoteModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  DailyNoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory DailyNoteModel.fromJson(Map<String, dynamic> json) {
    return DailyNoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  DailyNote toEntity() {
    return DailyNote(
      id: id,
      title: title,
      description: description,
      date: date,
    );
  }

  factory DailyNoteModel.fromEntity(DailyNote entity) {
    return DailyNoteModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      date: entity.date,
    );
  }
}
