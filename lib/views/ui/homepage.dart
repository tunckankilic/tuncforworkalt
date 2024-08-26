import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuncforworkalt/constants/app_constants.dart';
import 'package:tuncforworkalt/views/common/app_bar.dart';
import 'package:tuncforworkalt/views/common/app_style.dart';
import 'package:tuncforworkalt/views/common/drawer/drawer_widget.dart';
import 'package:tuncforworkalt/views/common/heading_widget.dart';
import 'package:tuncforworkalt/views/common/height_spacer.dart';
import 'package:tuncforworkalt/views/common/search.dart';
import 'package:tuncforworkalt/views/ui/jobs/job_page.dart';
import 'package:tuncforworkalt/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:tuncforworkalt/views/ui/jobs/widgets/job_tile.dart';
import 'package:tuncforworkalt/views/ui/search/searchpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(12.h),
                child: const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),
              )
            ],
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: const DrawerWidget(),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpacer(size: 10),
                Text(
                  "Search \nFind & Apply",
                  style: appstyle(
                      40, Color(AppConstants.kDark.value), FontWeight.bold),
                ),
                const HeightSpacer(size: 40),
                SearchWidget(
                  onTap: () {
                    Get.to(() => const SearchPage());
                  },
                ),
                const HeightSpacer(size: 30),
                HeadingWidget(
                  text: "Popular Jobs",
                  onTap: () {
                    // Get.to(() => const JobListPage());
                  },
                ),
                const HeightSpacer(size: 15),
                SizedBox(
                  height: height * 0.28,
                  child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return JobHorizontalTile(
                          onTap: () {
                            Get.to(() => JobPage(
                                title: AppConstants().job['company'],
                                id: AppConstants().job['_id']));
                          },
                          // job: job,
                        );
                      }),
                ),
                const HeightSpacer(size: 20),
                HeadingWidget(
                  text: "Recently Posted",
                  onTap: () {},
                ),
                const HeightSpacer(size: 20),
                SizedBox(
                  height: height * 0.16,
                  child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const VerticalTileWidget(

                            // job: job,
                            );
                      }),
                ),
              ],
            ),
          ),
        )));
  }
}
