import 'package:atma_vichara_gemastik/feature/domain/entities/annual_note.dart';

class AnnualNoteModel {
  final String id;
  final String title;
  final String description;
  final int date;

  AnnualNoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory AnnualNoteModel.fromJson(Map<String, dynamic> json) {
    return AnnualNoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  AnnualNote toEntity() {
    return AnnualNote(
      id: id,
      title: title,
      description: description,
      date: DateTime.fromMillisecondsSinceEpoch(date),
    );
  }

  factory AnnualNoteModel.fromEntity(AnnualNote entity) {
    return AnnualNoteModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      date: entity.date.millisecondsSinceEpoch,
    );
  }
}
