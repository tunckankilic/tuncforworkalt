import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tuncforworkalt/controllers/exports.dart';
import 'package:tuncforworkalt/models/request/auth/signup_model.dart';
import 'package:tuncforworkalt/views/common/app_bar.dart';
import 'package:tuncforworkalt/views/common/custom_btn.dart';
import 'package:tuncforworkalt/views/common/custom_textfield.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/height_spacer.dart';
import 'package:tuncforworkalt/views/ui/auth/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signupNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Sign Up',
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => const LoginPage(drawer: true));
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const HeightSpacer(size: 50),
                ReusableText(
                  text: 'Hello, Welcome!',
                  style: appstyle(
                      30, Color(AppConstants.kDark.value), FontWeight.w600),
                ),
                ReusableText(
                  text: 'Fill the details to signup for an account',
                  style: appstyle(
                    16,
                    Color(AppConstants.kDarkGrey.value),
                    FontWeight.w600,
                  ),
                ),
                const HeightSpacer(size: 50),
                CustomTextField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  hintText: 'Full name',
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  validator: (email) {
                    if (email!.isEmpty || !email.contains('@')) {
                      return 'Please enter a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: password,
                  keyboardType: TextInputType.text,
                  hintText: 'Password',
                  obscureText: signupNotifier.obscureText,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 8) {
                      return 'Please enter a valid password with at least 8 characters';
                    }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      signupNotifier.obscureText = !signupNotifier.obscureText;
                    },
                    child: Icon(
                      signupNotifier.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(AppConstants.kDark.value),
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.offAll(() => const LoginPage(drawer: true));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: 'Password should be at least 8 characters',
                          style: appstyle(
                              9, AppConstants.kOrange, FontWeight.w500),
                        ),
                        ReusableText(
                          text: 'Login',
                          style: appstyle(
                            14,
                            Color(AppConstants.kDark.value),
                            FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 50),
                CustomButton(
                  onTap: () {
                    if (_validateInputs()) {
                      final model = SignupModel(
                        username: name.text,
                        email: email.text,
                        password: password.text,
                      );
                      signupNotifier.upSignup(model);
                    }
                  },
                  text: 'Sign Up',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _validateInputs() {
    if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return false;
    }
    if (!email.text.contains('@')) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return false;
    }
    if (password.text.length < 8) {
      Get.snackbar('Error', 'Password should be at least 8 characters long');
      return false;
    }
    return true;
  }
}
