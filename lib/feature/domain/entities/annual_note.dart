class AnnualNote {
  final String id;
  // final String userId;
  final String title;
  final String description;
  final DateTime date;

  AnnualNote({
    required this.id,
    // required this.userId,
    required this.title,
    required this.description,
    required this.date,
  });

  factory AnnualNote.fromJson(Map<String, dynamic> json) {
    return AnnualNote(
      id: json['id'] as String,
      // userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'user_id': userId,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  AnnualNote copyWith({
    String? id,
    // String? userId,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return AnnualNote(
      id: id ?? this.id,
      // userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
