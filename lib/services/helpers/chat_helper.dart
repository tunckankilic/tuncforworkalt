import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuncforworkalt/models/request/chat/create_chat.dart';
import 'package:tuncforworkalt/models/response/chat/get_chat.dart';

class ChatHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Apply for job
  static Future<List<dynamic>> apply(CreateChat model) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return [false];

      DocumentReference docRef = await _firestore.collection('chats').add({
        ...model.toJson(),
        'userId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return [true, docRef.id];
    } catch (e) {
      debugPrint('Error applying for job: $e');
      return [false];
    }
  }

  static Future<List<GetChats>> getConversations() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) throw Exception("User not authenticated");

      QuerySnapshot querySnapshot = await _firestore
          .collection('chats')
          .where('userId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      List<GetChats> chats = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return GetChats.fromJson({...data, 'id': doc.id});
      }).toList();

      return chats;
    } catch (e, s) {
      debugPrint('ERROR: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  // Add this method to get a specific chat
  static Future<GetChats> getChat(String chatId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('chats').doc(chatId).get();

      if (!doc.exists) {
        throw Exception("Chat not found");
      }

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return GetChats.fromJson({...data, 'id': doc.id});
    } catch (e) {
      debugPrint('Error getting chat: $e');
      rethrow;
    }
  }

  // Add this method to send a message
  static Future<bool> sendMessage(String chatId, String message) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return false;

      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'text': message,
        'senderId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      debugPrint('Error sending message: $e');
      return false;
    }
  }
}
