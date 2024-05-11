import 'package:atma_vichara_gemastik/core/enum.dart';

class ReflectionTile {
  final String id;
  final ReflectionType type;
  final String title;
  final DateTime date;
  final String? note;

  ReflectionTile({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    this.note,
  });
}
