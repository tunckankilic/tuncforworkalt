import 'package:flutter/material.dart';
import 'package:tuncforworkalt/models/response/auth/profile_model.dart';
import 'package:tuncforworkalt/services/helpers/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  // Fix: make nullable for proper push to home after login

  Future<ProfileRes?>? profile;

  getProfile() async {
    profile = AuthHelper.getProfile();
  }
}
