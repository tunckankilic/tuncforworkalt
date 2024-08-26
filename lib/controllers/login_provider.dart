import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuncforworkalt/constants/app_constants.dart';
import 'package:tuncforworkalt/main.dart';
import 'package:tuncforworkalt/models/request/auth/login_model.dart';
import 'package:tuncforworkalt/models/request/auth/profile_update_model.dart';
import 'package:tuncforworkalt/services/helpers/auth_helper.dart';
import 'package:tuncforworkalt/views/ui/auth/login.dart';
import 'package:tuncforworkalt/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firstTime = true;

  bool get firstTime => _firstTime;

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    entrypoint = prefs.getBool('entrypoint') ?? false;
    final token = prefs.getString('token');
    if (token != null) {
      loggedIn = true;
    } else {
      loggedIn = false;
    }
  }

  final loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool profileValidation() {
    final form = profileFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> userLogin(LoginModel model) async {
    var response = await AuthHelper.login(model.email, model.password);
    if (response['success']) {
      Get.snackbar(
        'Login Success',
        'Enjoy your search for a job',
        colorText: Color(AppConstants.kLight.value),
        backgroundColor: Color(AppConstants.kLightBlue.value),
        icon: const Icon(Icons.add_alert),
      );

      await Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.offAll(() => const MainScreen());
      });
    } else {
      Get.snackbar(
        'Login Failed',
        response['message'],
        colorText: Color(AppConstants.kLight.value),
        backgroundColor: Color(AppConstants.kOrange.value),
        icon: const Icon(Icons.add_alert),
      );
    }
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
    await prefs.remove('profile');
    await prefs.remove('userId');
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      Get.offAll(() => LoginPage());
    });
  }

  Future<void> updateProfile(ProfileUpdateReq model) async {
    bool response = await AuthHelper.updateProfile(model.toJson());
    if (response) {
      Get.snackbar(
        'Profile Update',
        'Profile updated successfully',
        colorText: Color(AppConstants.kLight.value),
        backgroundColor: Color(AppConstants.kLightBlue.value),
        icon: const Icon(Icons.add_alert),
      );

      await Future.delayed(const Duration(seconds: 3));
      Get.offAll(() => const MainScreen());
    } else {
      Get.snackbar(
        'Updating Failed',
        'Please try again',
        colorText: Color(AppConstants.kLight.value),
        backgroundColor: Color(AppConstants.kOrange.value),
        icon: const Icon(Icons.add_alert),
      );
    }
  }
}
