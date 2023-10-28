import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'colors.dart';
import 'image_file.dart';

class StackBar extends StatelessWidget {
  const StackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      color: colorPrimary,
      child: Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: Column(
          children: [
            Image.asset(
              ImageFile.logo,
              height: 12.h,
            )
          ],
        ),
      ),
    );
  }
}
