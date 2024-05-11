import 'package:atma_vichara_gemastik/core/enum.dart';
import 'package:atma_vichara_gemastik/feature/domain/entities/reflection_tile.dart';

class ReflectionTileModel {
  final String id;
  final ReflectionType type;
  final String title;
  final int date;
  final String? note;

  ReflectionTileModel({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    this.note,
  });

  factory ReflectionTileModel.fromJson(Map<String, dynamic> json) {
    return ReflectionTileModel(
      id: json['id'],
      type: ReflectionType.values[json['type']],
      title: json['title'],
      date: json['date'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'title': title,
      'date': date,
      'note': note,
    };
  }

  ReflectionTile toEntity() {
    return ReflectionTile(
      id: id,
      type: type,
      title: title,
      date: DateTime.fromMillisecondsSinceEpoch(date),
      note: note,
    );
  }

  factory ReflectionTileModel.fromEntity(ReflectionTile entity) {
    return ReflectionTileModel(
      id: entity.id,
      type: entity.type,
      title: entity.title,
      date: entity.date.millisecondsSinceEpoch,
      note: entity.note,
    );
  }
}
