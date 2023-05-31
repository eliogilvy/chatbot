import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

import '../model/conversation.dart';

class MessagingProvider extends ChangeNotifier {
  MessagingProvider({required this.fb, required this.auth}) {
    initCollection();
  }

  final FirebaseAuth auth;
  final FirebaseFirestore fb;
  late CollectionReference _usersCollection;

  Future<List<Conversation>> get conversations async {
    return loadConversations();
  }

  // get stream of messages based on a convoid that is passed in
  Stream<List<types.Message>>? messages(String convoId) {
    final messageRef = _usersCollection
        .doc(auth.currentUser!.uid)
        .collection('conversations')
        .doc(convoId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();

    final query = messageRef.map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return types.TextMessage.fromJson(data);
      }).toList();
    });
    return query;
  }

  void initCollection() {
    _usersCollection = fb.collection('users');
  }

  Future<List<Conversation>> loadConversations({int? limit}) async {
    final userDocRef = _usersCollection.doc(auth.currentUser!.uid);
    // get the conversations for the current user with an optional limit
    final convoDocs = await userDocRef
        .collection('conversations')
        .orderBy('lastUpdated', descending: true)
        .get();

    // final convoDocs = await userDocRef
    //     .collection('conversations')
    //     .orderBy('lastUpdated', descending: true)
    //     .get();

    // final convoDocs = await userDocRef.collection('conversations').get();

    final query = convoDocs.docs.map((doc) {
      final data = doc.data();
      return Conversation.fromJson(data);
    }).toList();

    return query;
  }

  Future<Conversation> getConversation(String convoId) async {
    final userDocRef = _usersCollection.doc(auth.currentUser!.uid);
    final convoDocRef = userDocRef.collection('conversations').doc(convoId);
    final convoDoc = await convoDocRef.get();
    final data = convoDoc.data();
    return Conversation.fromJson(data!);
  }

  Future<void> addConversation(Conversation conversation) async {
    final userDocRef = _usersCollection.doc(auth.currentUser!.uid);
    final conversationDocRef =
        userDocRef.collection('conversations').doc(conversation.id);
    await conversationDocRef.set(conversation.toJson());
  }

  Future<void> addMessage(
      types.PartialText text, String conversationId, bool isBot) async {
    final message = createMessage(text, isBot);
    final userDocRef = _usersCollection.doc(auth.currentUser!.uid);
    final convoDocs =
        userDocRef.collection('conversations').doc(conversationId);
    await convoDocs.collection('messages').add(message.toJson());
  }

  types.TextMessage createMessage(types.PartialText text, bool isBot) {
    return types.TextMessage(
      id: const Uuid().v4(),
      author: isBot ? const types.User(id: 'bot') : getChatUser(),
      text: text.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  // Future<void> _simulateBotResponse(
  //     types.PartialText userMessage, String conversationId) async {
  //   types.PartialText botMessage = types.PartialText(
  //     text: 'Response to ${userMessage.text}',
  //   );
  //   final message = createMessage(botMessage, true);

  //   final conversationDocRef = _messagesCollection.doc(conversationId);
  //   await conversationDocRef.collection('messages').add(message.toJson());
  // }

  types.User getChatUser() {
    return types.User(
      id: auth.currentUser!.uid,
      firstName: auth.currentUser!.displayName,
    );
  }
}
