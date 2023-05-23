import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class MessagingProvider extends ChangeNotifier {
  MessagingProvider({required this.fb, required this.auth}) {
    initCollection();
  }
  final FirebaseAuth auth;
  final FirebaseFirestore fb;
  late CollectionReference _messagesCollection;

  void initCollection() {
    _messagesCollection = fb
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('messages');
  }

  // I want to return a stream of messages from the database in the form of a list of types.Message
  Stream<List<types.Message>> get messages {
    return _messagesCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return types.Message.fromJson(data);
      }).toList();
    });
  }

  // I want to add a message to the database using createMessage, take in the types.PartialText userMessage

  Future<void> addMessage(types.PartialText userMessage) async {
    final message = createMessage(userMessage, false);
    await _messagesCollection.add(
      message.toJson(),
    );
  }

  types.TextMessage createMessage(types.PartialText text, bool isBot) {
    return types.TextMessage(
      id: const Uuid().v4(),
      author: isBot ? const types.User(id: 'bot') : getChatUser(),
      text: text.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<void> _simulateBotResponse(types.PartialText userMessage) async {
    types.PartialText botMessage = types.PartialText(
      text: 'Response to ${userMessage.text}',
    );
    final message = createMessage(botMessage, true);

    await _messagesCollection.add({
      message.toJson(),
    });
  }

  types.User getChatUser() {
    return types.User(
      id: auth.currentUser!.uid,
      firstName: auth.currentUser!.displayName,
    );
  }
}
