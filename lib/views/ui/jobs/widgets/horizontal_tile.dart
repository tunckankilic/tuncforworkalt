import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/height_spacer.dart';
import 'package:tuncforworkalt/views/common/width_spacer.dart';

class JobHorizontalTile extends StatelessWidget {
  const JobHorizontalTile({super.key, this.onTap});

  final void Function()? onTap;
  // final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          width: width * 0.7,
          height: height * 0.27,
          color: Color(AppConstants.kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(AppConstants().job['imageUrl']),
                  ),
                  const WidthSpacer(width: 15),
                  ReusableText(
                      text: AppConstants().job['company'],
                      style: appstyle(26, Color(AppConstants.kDark.value),
                          FontWeight.w600)),
                ],
              ),
              const HeightSpacer(size: 15),
              ReusableText(
                  text: AppConstants().job['title'],
                  style: appstyle(
                      20, Color(AppConstants.kDark.value), FontWeight.w600)),
              ReusableText(
                  text: AppConstants().job['location'],
                  style: appstyle(16, Color(AppConstants.kDarkGrey.value),
                      FontWeight.w600)),
              const HeightSpacer(size: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ReusableText(
                          text: AppConstants().job['salary'],
                          style: appstyle(23, Color(AppConstants.kDark.value),
                              FontWeight.w600)),
                      ReusableText(
                          text: "/${AppConstants().job['period']}",
                          style: appstyle(
                              23,
                              Color(AppConstants.kDarkGrey.value),
                              FontWeight.w600)),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(AppConstants.kLight.value),
                    child: const Icon(Ionicons.chevron_forward),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
