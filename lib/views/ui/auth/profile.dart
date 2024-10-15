import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tuncforworkalt/controllers/profile_provider.dart';
import 'package:tuncforworkalt/models/response/auth/profile_model.dart';
import 'package:tuncforworkalt/views/common/app_bar.dart';
import 'package:tuncforworkalt/views/common/drawer/drawer_widget.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/height_spacer.dart';
import 'package:tuncforworkalt/views/common/width_spacer.dart';
import 'package:tuncforworkalt/views/ui/auth/profile_update.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Profile',
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
          profileNotifier.getProfile();
          return FutureBuilder<ProfileRes?>(
            future: profileNotifier.profile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No profile data available'));
              }

              final userData = snapshot.data!;
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  _buildProfileHeader(context, userData, profileNotifier),
                  const HeightSpacer(size: 20),
                  _buildResumeSection(),
                  const HeightSpacer(size: 20),
                  _buildInfoContainer(userData.email),
                  const HeightSpacer(size: 20),
                  _buildPhoneSection(userData.phone),
                  const HeightSpacer(size: 20),
                  _buildSkillsSection(userData.skills),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileRes userData,
      ProfileNotifier profileNotifier) {
    return Container(
      width: width,
      height: height * 0.12,
      color: Color(AppConstants.kLight.value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: userData.profile == null || userData.profile == 'null'
                    ? Image.asset('assets/images/user.png',
                        width: 80.w, height: 100.h)
                    : CachedNetworkImage(
                        width: 80.w,
                        height: 100.h,
                        imageUrl: userData.profile,
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/user.png'),
                      ),
              ),
              WidthSpacer(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                    text: userData.username,
                    style: appstyle(12.sp, Color(AppConstants.kDark.value),
                        FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(MaterialIcons.location_pin,
                          color: Color(AppConstants.kDarkGrey.value)),
                      const WidthSpacer(width: 5),
                      ReusableText(
                        text: userData.location,
                        style: appstyle(16, Color(AppConstants.kDarkGrey.value),
                            FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Get.to(() => const ProfileUpdate()),
            child: const Icon(Feather.edit, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeSection() {
    return Stack(
      children: [
        Container(
          width: width,
          height: height * 0.12,
          color: Color(AppConstants.kLightGrey.value),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 12.w),
                width: 60.w,
                height: 70.h,
                color: Color(AppConstants.kLight.value),
                child: const Icon(FontAwesome5Regular.file_pdf,
                    color: Colors.red, size: 40),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                    text: 'Resume from JobHub',
                    style: appstyle(
                        18, Color(AppConstants.kDark.value), FontWeight.w500),
                  ),
                  ReusableText(
                    text: 'JobHub Resume',
                    style: appstyle(16, Color(AppConstants.kDarkGrey.value),
                        FontWeight.w500),
                  ),
                ],
              ),
              const WidthSpacer(width: 1),
            ],
          ),
        ),
        Positioned(
          top: 2.h,
          right: 5.w,
          child: GestureDetector(
            onTap: () {},
            child: ReusableText(
              text: 'Edit',
              style: appstyle(
                  16, Color(AppConstants.kOrange.value), FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoContainer(String text) {
    return Container(
      padding: EdgeInsets.only(left: 8.w),
      width: width,
      height: height * 0.06,
      color: Color(AppConstants.kLightGrey.value),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ReusableText(
          text: text,
          style: appstyle(16, Color(AppConstants.kDark.value), FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildPhoneSection(String phone) {
    return Container(
      padding: EdgeInsets.only(left: 8.w),
      width: width,
      height: height * 0.06,
      color: Color(AppConstants.kLightGrey.value),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/usa.svg', width: 20.w, height: 20.h),
            const WidthSpacer(width: 15),
            ReusableText(
              text: phone,
              style: appstyle(
                  16, Color(AppConstants.kDark.value), FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(List<String> skills) {
    return Container(
      color: Color(AppConstants.kLightGrey.value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.h),
            child: ReusableText(
              text: 'Skills',
              style: appstyle(
                  16, Color(AppConstants.kDark.value), FontWeight.w600),
            ),
          ),
          const HeightSpacer(size: 3),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.h),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  width: width,
                  height: height * 0.06,
                  color: Color(AppConstants.kLight.value),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ReusableText(
                      text: skills[index],
                      style: appstyle(16, Color(AppConstants.kDark.value),
                          FontWeight.normal),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
