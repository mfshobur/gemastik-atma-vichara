import 'dart:convert';

import 'package:atma_vichara_gemastik/core/enum.dart';
import 'package:atma_vichara_gemastik/core/failure.dart';
import 'package:atma_vichara_gemastik/core/utils/firebase_message_parse.dart';
import 'package:atma_vichara_gemastik/core/utils/notifier_state.dart';
import 'package:atma_vichara_gemastik/feature/data/models/user_data_model.dart';
import 'package:atma_vichara_gemastik/feature/domain/entities/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserData? user;
  final NotifierState<void> signUpState = NotifierState<void>(value: null);
  final NotifierState<void> signInState = NotifierState<void>(value: null);
  final NotifierState<void> signOutState = NotifierState<void>(value: null);
  final NotifierState<void> getCurrentUserState = NotifierState<void>(value: null);

  Future<void> signIn(String email, String password) async {
    try {
      signInState.state = RequestState.loading;
      notifyListeners();

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userFromCredential = userCredential.user;
      // get user data from firestore
      final userDoc = await _firestore.collection('users').doc(userFromCredential!.uid).get();
      final userData = userDoc.data() as Map<String, dynamic>;
      user = UserDataModel.fromJson(userData).toEntity();
      await saveUserDataToLocal();
      signInState.state = RequestState.success;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseMessageParse.parseSignInError(e.code);

      signInState.state = RequestState.error;
      signInState.failure = BadRequestFailure(
        title: errorMessage,
        message: errorMessage,
      );
      notifyListeners();
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      signUpState.state = RequestState.loading;
      notifyListeners();
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userFromCredential = userCredential.user;
      // create new document on firestore
      await _firestore.collection('users').doc(userFromCredential!.uid).set({
        'name': name,
        'email': email,
        'uid': userFromCredential.uid,
      });

      user = UserData(
        name: name,
        email: email,
      );
      await saveUserDataToLocal();
      signUpState.state = RequestState.success;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseMessageParse.parseSignUpError(e.code);
      signUpState.state = RequestState.error;
      signUpState.failure = BadRequestFailure(
        title: errorMessage,
        message: errorMessage,
      );
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    signOutState.state = RequestState.loading;
    notifyListeners();
    await _auth.signOut();
    // remove user data from local
    signOutState.state = RequestState.success;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    user = null;
  }

  Future<void> getCurrentUser() async {
    getCurrentUserState.state = RequestState.loading;
    notifyListeners();
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      // read data from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      if (userJson != null) {
        user = UserDataModel.fromJson(json.decode(userJson)).toEntity();
        getCurrentUserState.state = RequestState.success;
      } else {
        getCurrentUserState.state = RequestState.error;
      }
      notifyListeners();
    } else {
      getCurrentUserState.state = RequestState.error;
      notifyListeners();
    }
  }

  // save user data to local
  Future<void> saveUserDataToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(UserDataModel.fromEntity(user!).toJson()));
  }
}
