import 'package:atma_vichara_gemastik/core/enum.dart';
import 'package:atma_vichara_gemastik/core/utils/notifier_state.dart';
import 'package:atma_vichara_gemastik/feature/domain/entities/reflection_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ReflectionNotifier extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final NotifierState<void> submitReflectionState = NotifierState<void>(value: null);
  final NotifierState<void> resetReflectionState = NotifierState<void>(value: null);
  final NotifierState<String?> generateReflectionResponseState =
      NotifierState<String?>(value: null);

  Future<void> submitReflection(
    ReflectionType type,
    List<String> answers,
    String userId,
  ) async {
    try {
      submitReflectionState.state = RequestState.loading;
      notifyListeners();

      String answerType = type == ReflectionType.past
          ? 'past_answers'
          : type == ReflectionType.present
              ? 'present_answers'
              : 'future_answers';
      String alreadyReflectType = type == ReflectionType.past
          ? 'already_reflect_past'
          : type == ReflectionType.present
              ? 'already_reflect_present'
              : 'already_reflect_future';
      final user = _firestore.collection('users').doc(userId);

      await user.update({
        alreadyReflectType: true,
        answerType: answers,
      });

      submitReflectionState.state = RequestState.success;
      notifyListeners();
    } catch (e) {
      submitReflectionState.state = RequestState.error;
      notifyListeners();
      submitReflectionState.state = RequestState.initial;
    }
  }

  Future<void> getReflectionResponse(
    String userId,
    List<ReflectionResult> past,
    List<ReflectionResult> present,
    List<ReflectionResult> future,
  ) async {
    generateReflectionResponseState.state = RequestState.loading;
    notifyListeners();

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    );

    String prompt =
        'I want you to act like a therapists. i have list of questions and aswers about my past, present, and future. and i want you to act as my therapist and comment my answers. comment everything packed in 2 long paragraphs without make a number point on each answer. dont divide your comment into past, present, and future.\n';

    prompt += "Past Section";
    for (int i = 0; i < past.length; i++) {
      ReflectionResult reflection = past[i];
      prompt += '${i + 1}. question: ${reflection.question}\n';
      prompt += 'answer: ${reflection.answer}\n';
    }

    prompt += "Present Section";
    for (int i = 0; i < present.length; i++) {
      ReflectionResult reflection = present[i];
      prompt += '${i + 1}. question: ${reflection.question}\n';
      prompt += 'answer: ${reflection.answer}\n';
    }

    prompt += "Future Section";
    for (int i = 0; i < future.length; i++) {
      ReflectionResult reflection = future[i];
      prompt += '${i + 1}. question: ${reflection.question}\n';
      prompt += 'answer: ${reflection.answer}\n';
    }

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    // update data on firestore
    final user = _firestore.collection('users').doc(userId);
    await user.update({
      'reflection_response': response.text,
    });

    generateReflectionResponseState.state = RequestState.success;
    generateReflectionResponseState.value = response.text;
    notifyListeners();
  }

  Future<void> resetReflection(ReflectionType type, String userId) async {
    try {
      resetReflectionState.state = RequestState.loading;
      notifyListeners();

      String answerType = type == ReflectionType.past
          ? 'past_answers'
          : type == ReflectionType.present
              ? 'present_answers'
              : 'future_answers';
      String alreadyReflectType = type == ReflectionType.past
          ? 'already_reflect_past'
          : type == ReflectionType.present
              ? 'already_reflect_present'
              : 'already_reflect_future';
      final user = _firestore.collection('users').doc(userId);

      await user.update({
        alreadyReflectType: false,
        answerType: null,
      });

      resetReflectionState.state = RequestState.success;
      notifyListeners();
    } catch (e) {
      resetReflectionState.state = RequestState.error;
      notifyListeners();
    }
  }

  void initState() {
    submitReflectionState.state = RequestState.initial;
    resetReflectionState.state = RequestState.initial;
  }
}
