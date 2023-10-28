import 'package:ancientmysticmusic/screen/notification/notificationpopup.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationUI extends StatefulWidget {
  const NotificationUI({super.key});

  @override
  State<NotificationUI> createState() => _NotificationUIState();
}

class NotificationList {
  NotificationList(
    this.title,
    this.subtitle,
    this.date,
    this.tim,
    this.image,
  );

  final String title;
  final String subtitle;
  final String date;
  final String tim;
  final String image;
}

class _NotificationUIState extends State<NotificationUI> {
  final List<NotificationList> notificationlist = [
    NotificationList(
      "Lorem Ipsum's new releases:",
      "lorem Ipusm",
      "2022-10-20",
      "16:04",
      "m2.jpg",
    ),
    NotificationList(
      "Lorem Ipsum's new releases:",
      "lorem Ipusm",
      "2022-10-20",
      "16:04",
      "m2.jpg",
    ),
    NotificationList(
      "Lorem Ipsum's new releases:",
      "lorem Ipusm",
      "2022-10-20",
      "16:04",
      "m2.jpg",
    ),
    NotificationList(
      "Lorem Ipsum's new releases:",
      "52 Song",
      "2022-10-20",
      "16:04",
      "m2.jpg",
    ),
  ];

  bool showpop = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.5.h),
      child: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          //   alignment: Alignment.center,
          children: [
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          showpop = true;
                          // add data here
                        });
                      },
                      child: Container(
                        height: 8.h,
                        decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(4.w)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 0.5.h,
                              left: 1.0.h,
                              right: 1.0.h,
                              bottom: 0.5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 0.5.w,
                                    ),
                                    Text(notificationlist[index].title,
                                        style: Style_File.title.copyWith(
                                            color: colorPrimary,
                                            fontSize: 15.sp)),
                                    SizedBox(
                                      height: 0.5.w,
                                    ),
                                    Text(notificationlist[index].subtitle,
                                        style: Style_File.subtitle
                                            .copyWith(color: colorBlack)),
                                    SizedBox(
                                      height: 0.5.w,
                                    ),
                                    Row(
                                      children: [
                                        Text(notificationlist[index].date,
                                            style: Style_File.subtitle
                                                .copyWith(color: colorBlack)),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(notificationlist[index].tim,
                                            style: Style_File.subtitle
                                                .copyWith(color: colorBlack)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                height: 10.h,
                                width: 10.w,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/m2.jpg'),
                                  backgroundColor: colorPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    )
                  ],
                );
              },
              itemCount: notificationlist.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
            ),
            if (showpop)
              Container(
                height: 100.h,
                width: 100.w,
                color: Colors.transparent,
                child: NotificationpopScreen(
                  //  notificationData: notificationData,
                  callback: (value) {
                    print(value);
                    setState(() {
                      showpop = false;
                    });
                  },
                ),
              ),
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
    );
  }
}
