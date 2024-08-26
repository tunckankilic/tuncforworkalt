import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/width_spacer.dart';
import 'package:tuncforworkalt/views/ui/jobs/job_page.dart';

class VerticalTileWidget extends StatelessWidget {
  const VerticalTileWidget({
    super.key,
  });
  // final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, right: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(() => JobPage(
              title: AppConstants().job['company'],
              id: AppConstants().job['_id']));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: height * 0.15,
          width: width * 0.88,
          color: Color(AppConstants.kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(AppConstants().job['imageUrl']),
                      ),
                      const WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                              text: AppConstants().job['company'],
                              style: appstyle(
                                  20,
                                  Color(AppConstants.kDark.value),
                                  FontWeight.w600)),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                                text: AppConstants().job['title'],
                                style: appstyle(
                                    20,
                                    Color(AppConstants.kDarkGrey.value),
                                    FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    child: Icon(
                      Ionicons.chevron_forward,
                      color: Color(AppConstants.kOrange.value),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.w),
                child: Row(
                  children: [
                    ReusableText(
                        text: AppConstants().job['salary'],
                        style: appstyle(22, Color(AppConstants.kDark.value),
                            FontWeight.w600)),
                    ReusableText(
                        text: "/${AppConstants().job['period']}",
                        style: appstyle(20, Color(AppConstants.kDarkGrey.value),
                            FontWeight.w600)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
