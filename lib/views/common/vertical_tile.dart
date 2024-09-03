import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tuncforworkalt/models/response/jobs/jobs_response.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/width_spacer.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({required this.job, super.key, this.onTap});

  final JobsResponse? job;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: height * 0.15,
        width: width,
        decoration: BoxDecoration(
          color: Color(AppConstants.kLightGrey.value),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Fix: added this to remove "RenderFlex children have non-zero flex but incoming width constraints are unbounded."
                SizedBox(
                  width: width * 0.78,
                  child: Row(
                    // Fix: added this to remove "RenderFlex children have non-zero flex but incoming width constraints are unbounded."
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(AppConstants.kLightGrey.value),
                        radius: 25,
                        backgroundImage: NetworkImage(job!.imageUrl),
                      ),
                      const WidthSpacer(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job!.company,
                              style: appstyle(
                                16,
                                Color(AppConstants.kDark.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job!.title,
                              style: appstyle(
                                16,
                                Color(AppConstants.kDarkGrey.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(AppConstants.kLight.value),
                        child: const Icon(Ionicons.chevron_forward),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.w),
              child: Row(
                children: [
                  ReusableText(
                    text: job!.salary,
                    style: appstyle(
                        23, Color(AppConstants.kDark.value), FontWeight.w600),
                  ),
                  ReusableText(
                    text: '/${job!.period}',
                    style: appstyle(
                      20,
                      Color(AppConstants.kDarkGrey.value),
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
