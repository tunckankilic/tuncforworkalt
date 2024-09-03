import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:tuncforworkalt/controllers/exports.dart';
import 'package:tuncforworkalt/models/request/bookmarks/bookmarks_model.dart';
import 'package:tuncforworkalt/models/request/chat/create_chat.dart';
import 'package:tuncforworkalt/models/message.dart';
import 'package:tuncforworkalt/services/helpers/chat_helper.dart';
import 'package:tuncforworkalt/services/helpers/messaging_helper.dart';
import 'package:tuncforworkalt/views/common/app_bar.dart';
import 'package:tuncforworkalt/views/common/custom_outline_btn.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/height_spacer.dart';
import 'package:tuncforworkalt/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:tuncforworkalt/models/response/jobs/jobs_response.dart';

class JobPage extends StatelessWidget {
  const JobPage({
    required this.title,
    required this.id,
    required this.jobData,
    super.key,
  });

  final String title;
  final String id;
  final JobsResponse jobData;

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: title,
              actions: [
                Consumer<BookMarkNotifier>(
                  builder: (context, bookMarkNotifier, child) {
                    bookMarkNotifier.loadJobs();
                    return GestureDetector(
                      onTap: () {
                        if (bookMarkNotifier.jobs.contains(id)) {
                          bookMarkNotifier.deleteBookMark(id);
                        } else {
                          var model = BookmarkReqModel(
                            job: id,
                            userId: jobData.agentId,
                            title: title,
                            imageUrl: jobData.imageUrl,
                            company: jobData.company,
                            location: jobData.location,
                          );
                          bookMarkNotifier.addBookMark(model, id);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.0.w),
                        child: !bookMarkNotifier.jobs.contains(id)
                            ? const Icon(Fontisto.bookmark)
                            : const Icon(Fontisto.bookmark_alt),
                      ),
                    );
                  },
                ),
              ],
              child: GestureDetector(
                onTap: Get.back,
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
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
                            backgroundImage: NetworkImage(jobData.imageUrl),
                          ),
                          const HeightSpacer(size: 10),
                          ReusableText(
                            text: jobData.title,
                            style: appstyle(
                              22,
                              Color(AppConstants.kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          const HeightSpacer(size: 5),
                          ReusableText(
                            text: jobData.location,
                            style: appstyle(
                              16,
                              Color(AppConstants.kDarkGrey.value),
                              FontWeight.normal,
                            ),
                          ),
                          const HeightSpacer(size: 15),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: SizedBox(
                              width: width * 0.6,
                              child: ReusableText(
                                text: '${jobData.salary} ${jobData.period} ',
                                style: appstyle(
                                  18,
                                  Color(AppConstants.kDark.value),
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const HeightSpacer(size: 20),
                    ReusableText(
                      text: jobData.title,
                      style: appstyle(
                        18,
                        Color(AppConstants.kDark.value),
                        FontWeight.w600,
                      ),
                    ),
                    const HeightSpacer(size: 10),
                    Text(
                      jobData.description,
                      textAlign: TextAlign.justify,
                      maxLines: 8,
                      style: appstyle(
                        14,
                        Color(AppConstants.kDarkGrey.value),
                        FontWeight.normal,
                      ),
                    ),
                    const HeightSpacer(size: 20),
                    ReusableText(
                      text: 'Requirements',
                      style: appstyle(
                        22,
                        Color(AppConstants.kDark.value),
                        FontWeight.w600,
                      ),
                    ),
                    const HeightSpacer(size: 10),
                    SizedBox(
                      height: height * 0.6,
                      child: ListView.builder(
                        itemCount: jobData.requirements.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final req = jobData.requirements[index];
                          const bullet = '\u2022';
                          return Text(
                            '$bullet $req\n',
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            style: appstyle(
                              16,
                              Color(AppConstants.kDarkGrey.value),
                              FontWeight.normal,
                            ),
                          );
                        },
                      ),
                    ),
                    const HeightSpacer(size: 20),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: CustomOutlineBtn(
                      onTap: () async {
                        final chatModel = CreateChat(userId: jobData.agentId);
                        print(chatModel.userId);
                        await ChatHelper.apply(chatModel).then((response) {
                          if (response[0]) {
                            final messageModel = Message(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              senderId:
                                  "currentUserId", // Replace with actual current user ID
                              receiverId: jobData.agentId,
                              content:
                                  "Hello, I'm interested in ${jobData.title}",
                              timestamp: DateTime.now(),
                            );
                            FirebaseMessagingHelper.sendMessage(messageModel)
                                .whenComplete(() {
                              Get.to(() => const MainScreen());
                            });
                          }
                        });
                      },
                      color2: Color(AppConstants.kOrange.value),
                      width: width,
                      hieght: height * 0.06,
                      text: 'Apply Now',
                      color: Color(AppConstants.kLight.value),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
