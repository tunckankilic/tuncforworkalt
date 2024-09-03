import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuncforworkalt/models/message.dart';

class FirebaseMessagingHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Send Message
  static Future<List<dynamic>> sendMessage(Message message) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return [false, 'User not authenticated'];
      }

      final messageRef = _firestore.collection('messages').doc();
      final messageData = message.toFirestore();
      messageData['id'] = messageRef.id;

      await messageRef.set(messageData);

      return [true, Message.fromFirestore(await messageRef.get()), messageData];
    } catch (e) {
      debugPrint('Error sending message: $e');
      return [false, 'Failed to send message'];
    }
  }

  // Get Messages
  static Stream<List<Message>> getMessages(String chatId, int limit) {
    return _firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
  }

  // Load More Messages
  static Future<List<Message>> loadMoreMessages(
      String chatId, DateTime lastMessageTimestamp, int limit) async {
    try {
      final querySnapshot = await _firestore
          .collection('messages')
          .where('chatId', isEqualTo: chatId)
          .orderBy('timestamp', descending: true)
          .startAfter([Timestamp.fromDate(lastMessageTimestamp)])
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => Message.fromFirestore(doc))
          .toList();
    } catch (e) {
      debugPrint('Error loading more messages: $e');
      return [];
    }
  }

  // Mark Message as Read
  static Future<void> markMessageAsRead(String messageId) async {
    try {
      await _firestore.collection('messages').doc(messageId).update({
        'isRead': true,
      });
    } catch (e) {
      debugPrint('Error marking message as read: $e');
    }
  }

  // Delete Message
  static Future<bool> deleteMessage(String messageId) async {
    try {
      await _firestore.collection('messages').doc(messageId).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting message: $e');
      return false;
    }
  }

  // Set User Online Status
  static Future<void> setUserOnlineStatus(bool isOnline) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'isOnline': isOnline,
          'lastSeen': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      debugPrint('Error setting user online status: $e');
    }
  }
}
