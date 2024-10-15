import 'package:flutter/material.dart';
import 'package:tuncforworkalt/models/response/auth/profile_model.dart';
import 'package:tuncforworkalt/services/helpers/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<ProfileRes?>? _profileFuture;
  Future<ProfileRes?>? get profile => _profileFuture;

  void getProfile() {
    _profileFuture = AuthHelper.getProfile();
    notifyListeners();
  }
}
