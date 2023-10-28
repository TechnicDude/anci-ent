import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class NoDataFoundErrorScreens extends StatelessWidget {
  double? height;
  NoDataFoundErrorScreens({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height != null ? height : 65.h,
        width: 80.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No data found",
                style: Style_File.title
                    .copyWith(color: Colors.grey, fontSize: 18.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              Image.asset(
                ImageFile.notfound,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
