import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationpopScreen extends StatelessWidget {
  final Function? callback;

  const NotificationpopScreen({
    Key? key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 2.w, right: 2.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Lorem Ipsum",
                  //  notificationData!.title!,
                  style: Style_File.title.copyWith(color: colorSecondry),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "test",
                  //  notificationData!.userQuery!.name!,
                  style: Style_File.title
                      .copyWith(color: colorBlack, fontSize: 15.sp),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "test@gmail.com",
                  // notificationData!.userQuery!.email!,
                  style: Style_File.title
                      .copyWith(color: colorBlack, fontSize: 15.sp),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "9090909090",
                  // notificationData!.userQuery!.mobile!,
                  style: Style_File.subtitle.copyWith(color: colorBlack),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "26-09-2022",
                      //   notificationData!.userQuery!.date!,
                      style: Style_File.subtitle.copyWith(color: colorBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                  height: 1.h,
                ),
                SingleChildScrollView(
                  child: Text(
                    "test 1",
                    //notificationData!.userQuery!.message!,
                    style: Style_File.subtitle.copyWith(color: colorBlack),
                  ),
                )
              ],
            ),
            Positioned(
              top: -2.h,
              right: -1.w,
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                child: IconButton(
                  color: colorWhite,
                  onPressed: () {
                    callback!("ok");
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
