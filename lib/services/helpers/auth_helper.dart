import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuncforworkalt/models/request/auth/signup_model.dart';
import 'package:tuncforworkalt/models/response/auth/profile_model.dart';

class AuthHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        String token = await userCredential.user!.getIdToken() ?? '';
        String userId = userCredential.user!.uid;

        await prefs.setString('token', token);
        await prefs.setString('userId', userId);
        await prefs.setBool('loggedIn', true);

        return {'success': true, 'message': 'Login successful'};
      }
      return {'success': false, 'message': 'Login failed'};
    } catch (e) {
      print('Login error: $e');
      return {'success': false, 'message': 'Login error: $e'};
    }
  }

  static Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update(profileData);
        return true;
      }
      return false;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> signup(SignupModel model) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          '_id': userCredential.user!.uid,
          'username': model.username,
          'email': model.email,
          'isAdmin': false,
          'isAgent': false,
          'skills': [],
          'updatedAt': FieldValue.serverTimestamp(),
          'location': '',
          'phone': '',
          'profile': '',
        });
        return {'success': true, 'message': 'Signup successful'};
      }
      return {'success': false, 'message': 'Signup failed'};
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      return {'success': false, 'message': message};
    } catch (e) {
      print('Signup error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred. Please try again.'
      };
    }
  }

  static Future<ProfileRes?> getProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          return ProfileRes(
            id: data['_id'] ?? '',
            username: data['username'] ?? '',
            email: data['email'] ?? '',
            isAdmin: data['isAdmin'] ?? false,
            isAgent: data['isAgent'] ?? false,
            skills: List<String>.from(data['skills'] ?? []),
            updatedAt: _parseTimestamp(data['updatedAt']),
            location: data['location'] ?? '',
            phone: data['phone'] ?? '',
            profile: data['profile'] ?? '',
          );
        }
      }
      return null;
    } catch (e) {
      print('Get profile error: $e');
      throw Exception("Failed to get the profile: $e");
    }
  }

  static DateTime _parseTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }
}
