import 'dart:convert';

import 'package:atma_vichara_gemastik/core/enum.dart';
import 'package:atma_vichara_gemastik/core/utils/notifier_state.dart';
import 'package:atma_vichara_gemastik/feature/domain/entities/annual_note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteNotifier extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<AnnualNote> notes = [];

  final NotifierState<AnnualNote?> getNotesState = NotifierState(value: null);
  final NotifierState<void> addNoteState = NotifierState(value: null);
  final NotifierState<void> updateNoteState = NotifierState(value: null);
  final NotifierState<void> deleteNoteState = NotifierState(value: null);

  Future<void> getNotes(String userId) async {
    getNotesState.state = RequestState.loading;
    notifyListeners();

    final response = await _firestore.collection('notes').doc(userId).get();
    final data = response.data() as Map<String, dynamic>;
    final notes = data['notes'] as List<dynamic>;
    for (int i = 0; i < notes.length; i++) {
      this.notes.add(AnnualNote.fromJson(notes[i]));
    }

    await saveNotesToLocal();

    getNotesState.state = RequestState.success;
    notifyListeners();
  }

  Future<void> getNotesFromLocal() async {
    getNotesState.state = RequestState.loading;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getString('notes');
    if (notesString != null) {
      final notesJson = json.decode(notesString) as List<dynamic>;
      notes.clear();
      for (int i = 0; i < notesJson.length; i++) {
        notes.add(AnnualNote.fromJson(notesJson[i]));
      }
    }

    getNotesState.state = RequestState.success;
    notifyListeners();
  }

  Future<void> addNote(AnnualNote note, String userId) async {
    addNoteState.state = RequestState.loading;
    notifyListeners();

    await _firestore.collection('notes').doc(userId).update({
      'notes': FieldValue.arrayUnion([note.toJson()]),
    });

    notes.add(note);

    await saveNotesToLocal();

    addNoteState.state = RequestState.success;

    notifyListeners();
  }

  Future<void> updateNote(AnnualNote note, String userId) async {
    updateNoteState.state = RequestState.loading;
    notifyListeners();

    // replace the old note with the new one
    final index = notes.indexWhere((element) => element.id == note.id);
    notes[index] = note;

    await _firestore.collection('notes').doc(userId).update({
      'notes': notes.map((e) => e.toJson()).toList(),
    });

    await saveNotesToLocal();

    updateNoteState.state = RequestState.success;
    notifyListeners();
  }

  Future<void> deleteNote(AnnualNote note, String userId) async {
    deleteNoteState.state = RequestState.loading;
    notifyListeners();

    await _firestore.collection('notes').doc(userId).update({
      'notes': FieldValue.arrayRemove([note.toJson()]),
    });

    await saveNotesToLocal();

    deleteNoteState.state = RequestState.success;
    notifyListeners();
  }

  Future<void> saveNotesToLocal() async {
    // save notes to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notes', json.encode(notes.map((e) => e.toJson()).toList()));
  }

  void clearState() {
    addNoteState.state = RequestState.initial;
    updateNoteState.state = RequestState.initial;
    deleteNoteState.state = RequestState.initial;
  }

  void clearNotes() {
    notes.clear();
  }
}
