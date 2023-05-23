import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider({required this.firebaseAuth, required this.fb});

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore fb;

  User? get user => firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<String?> signUpWithEmail(
      String email, String password, String name) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await initUser(email, name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return 'Unknown error occured';
    }
    return null;
  }

  Future<void> initUser(String email, String name) async {
    await fb
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set({'username': name, 'email': email});

    // create initial flutter_chat_ui textmessage
    final welcome = types.TextMessage(
      id: const Uuid().v4(),
      author: const types.User(id: 'bot'),
      text: 'Welcome to Buddy Chat!',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    // add collection for messages using flutter_chat_ui textmessage
    await fb
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('messages')
        .doc(welcome.id)
        .set(
          welcome.toJson(),
        );
  }

  Future<String?> signInWithEmail(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return 'Unknown error occured';
    }
    return null;
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}