import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:tuncforworkalt/controllers/exports.dart';
import 'package:tuncforworkalt/views/common/app_bar.dart';
import 'package:tuncforworkalt/views/common/custom_outline_btn.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/height_spacer.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        // jobsNotifier.getJob(widget.id);
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: CustomAppBar(
                  text: widget.title,
                  actions: [
                    Consumer<BookMarkNotifier>(
                      builder: (context, bookMarkNotifier, child) {
                        // bookMarkNotifier.loadJobs();
                        return GestureDetector(
                          onTap: () {
                            // if (bookMarkNotifier.jobs.contains(widget.id)) {
                            //   bookMarkNotifier.deleteBookMark(widget.id);
                            // } else {
                            //   BookmarkReqResModel model =
                            //       BookmarkReqResModel(job: widget.id);
                            //   bookMarkNotifier.addBookMark(model, widget.id);
                            // }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Icon(Fontisto.bookmark),
                          ),
                        );
                      },
                    )
                  ],
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(CupertinoIcons.arrow_left),
                  )),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const HeightSpacer(size: 30),
                      Container(
                        width: width,
                        height: height * 0.27,
                        color: Color(AppConstants.kLightGrey.value),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(AppConstants().job['imageUrl']),
                            ),
                            const HeightSpacer(size: 10),
                            ReusableText(
                                text: AppConstants().job['title'],
                                style: appstyle(
                                    22,
                                    Color(AppConstants.kDark.value),
                                    FontWeight.w600)),
                            const HeightSpacer(size: 5),
                            ReusableText(
                                text: AppConstants().job['location'],
                                style: appstyle(
                                    16,
                                    Color(AppConstants.kDarkGrey.value),
                                    FontWeight.normal)),
                            const HeightSpacer(size: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomOutlineBtn(
                                      width: width * 0.26,
                                      hieght: height * 0.04,
                                      color2: Color(AppConstants.kLight.value),
                                      text: AppConstants().job['contract'],
                                      color: Color(AppConstants.kOrange.value)),
                                  Row(
                                    children: [
                                      ReusableText(
                                          text: AppConstants().job['salary'],
                                          style: appstyle(
                                              22,
                                              Color(AppConstants.kDark.value),
                                              FontWeight.w600)),
                                      SizedBox(
                                        width: width * 0.2,
                                        child: ReusableText(
                                            text:
                                                "/${AppConstants().job['period']}",
                                            style: appstyle(
                                                22,
                                                Color(AppConstants.kDark.value),
                                                FontWeight.w600)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const HeightSpacer(size: 20),
                      ReusableText(
                          text: AppConstants().job['description'],
                          style: appstyle(22, Color(AppConstants.kDark.value),
                              FontWeight.w600)),
                      const HeightSpacer(size: 10),
                      Text(
                        AppConstants().desc,
                        textAlign: TextAlign.justify,
                        maxLines: 8,
                        style: appstyle(16, Color(AppConstants.kDarkGrey.value),
                            FontWeight.normal),
                      ),
                      const HeightSpacer(size: 20),
                      ReusableText(
                          text: "Requirements",
                          style: appstyle(22, Color(AppConstants.kDark.value),
                              FontWeight.w600)),
                      const HeightSpacer(size: 10),
                      SizedBox(
                        height: height * 0.6,
                        child: ListView.builder(
                            itemCount:
                                AppConstants().job['requirements'].length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final req =
                                  AppConstants().job['requirements'][index];
                              String bullet = "\u2022";
                              return Text(
                                "$bullet $req\n",
                                maxLines: 4,
                                textAlign: TextAlign.justify,
                                style: appstyle(
                                    16,
                                    Color(AppConstants.kDarkGrey.value),
                                    FontWeight.normal),
                              );
                            }),
                      ),
                      const HeightSpacer(size: 20),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: CustomOutlineBtn(
                          onTap: () {},
                          color2: Color(AppConstants.kOrange.value),
                          width: width,
                          hieght: height * 0.06,
                          text: "Apply Now",
                          color: Color(AppConstants.kLight.value)),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
