import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tuncforworkalt/views/common/exports.dart';
import 'package:tuncforworkalt/views/common/height_spacer.dart';
import 'package:tuncforworkalt/views/common/width_spacer.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width * 0.83,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Feather.search,
                      color: Color(AppConstants.kOrange.value),
                      size: 20.h,
                    ),
                    const WidthSpacer(width: 20),
                    ReusableText(
                        text: "Search for jobs",
                        style: appstyle(18, Color(AppConstants.kOrange.value),
                            FontWeight.w500))
                  ],
                ),
              ),
              Icon(
                FontAwesome.sliders,
                color: Color(AppConstants.kDarkGrey.value),
                size: 20.h,
              )
            ],
          ),
          const HeightSpacer(size: 7),
          Divider(
            color: Color(AppConstants.kDarkGrey.value),
            thickness: 0.5,
            endIndent: 40.w,
          )
        ],
      ),
    );
  }
}
