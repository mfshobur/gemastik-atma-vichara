class UserData {
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

  UserData({
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

  UserData copyWith({
    String? id,
    String? name,
    String? email,
    bool? alreadyReflectPast,
    bool? alreadyReflectPresent,
    bool? alreadyReflectFuture,
    List<String>? pastAnswers,
    List<String>? presentAnswers,
    List<String>? futureAnswers,
    String? reflectionResponse,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      alreadyReflectPast: alreadyReflectPast ?? this.alreadyReflectPast,
      alreadyReflectPresent: alreadyReflectPresent ?? this.alreadyReflectPresent,
      alreadyReflectFuture: alreadyReflectFuture ?? this.alreadyReflectFuture,
      pastAnswers: pastAnswers ?? this.pastAnswers,
      presentAnswers: presentAnswers ?? this.presentAnswers,
      futureAnswers: futureAnswers ?? this.futureAnswers,
      reflectionResponse: reflectionResponse ?? this.reflectionResponse,
    );
  }
}
