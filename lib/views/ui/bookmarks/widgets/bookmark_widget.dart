import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:tuncforworkalt/models/response/bookmarks/all_bookmarks.dart';
import 'package:tuncforworkalt/models/response/jobs/jobs_response.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/width_spacer.dart';
import 'package:tuncforworkalt/views/ui/jobs/job_page.dart';

class BookMarkTileWidget extends StatelessWidget {
  const BookMarkTileWidget({required this.job, super.key});
  final AllBookmark job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          Get.to(() => JobPage(
                title: job.job.company,
                id: job.job.id,
                jobData: job.job as JobsResponse, // Pass the entire job object
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: height * 0.15,
          width: width,
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
                        backgroundImage: NetworkImage(job.job.imageUrl),
                      ),
                      const WidthSpacer(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: job.job.company,
                            style: appstyle(
                              20,
                              Color(AppConstants.kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job.job.title,
                              style: appstyle(
                                20,
                                Color(AppConstants.kDarkGrey.value),
                                FontWeight.w600,
                              ),
                            ),
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
                      text: job.job.salary,
                      style: appstyle(
                          22, Color(AppConstants.kDark.value), FontWeight.w600),
                    ),
                    ReusableText(
                      text: '/${job.job.period}',
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
      ),
    );
  }
}
