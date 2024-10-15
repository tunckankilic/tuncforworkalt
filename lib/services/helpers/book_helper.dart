import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuncforworkalt/models/request/bookmarks/bookmarks_model.dart';
import 'package:tuncforworkalt/models/response/bookmarks/all_bookmarks.dart';

class BookMarkHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // ADD BOOKMARKS
  static Future<List<dynamic>> addBookmarks(BookmarkReqModel model) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return [false];

      DocumentReference docRef = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks')
          .add(model.toJson());

      return [true, docRef.id];
    } catch (e) {
      log('Error adding bookmark: $e');
      return [false];
    }
  }

  // DELETE BOOKMARKS
  static Future<bool> deleteBookmarks(String jobId) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return false;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks')
          .doc(jobId)
          .delete();

      return true;
    } catch (e) {
      log('Error deleting bookmark: $e');
      return false;
    }
  }

  // GET BOOKMARKS
  static Future<List<AllBookmark>> getBookmarks() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks')
          .get();

      List<AllBookmark> bookmarks = querySnapshot.docs
          .map(
              (doc) => AllBookmark.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return bookmarks;
    } catch (e) {
      log('Error getting bookmarks: $e');
      throw Exception('Failed to load bookmarks');
    }
  }
}
