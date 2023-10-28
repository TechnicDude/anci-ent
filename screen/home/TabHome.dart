import 'package:ancientmysticmusic/screen/auth/login.dart';
import 'package:ancientmysticmusic/screen/auth/signup.dart';
import 'package:ancientmysticmusic/screen/home/recentplaylist.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/stack_bar.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TabsHome extends StatefulWidget {
  const TabsHome({Key? key}) : super(key: key);

  @override
  State<TabsHome> createState() => _TabsHomeState();
}

class _TabsHomeState extends State<TabsHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 35.0.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: colorGrey),
      child: DefaultTabController(
          length: 3, // length of tabs
          initialIndex: 0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),
                  child: Container(
                    height: 4.h,
                    child: TabBar(
                      unselectedLabelColor: colorWhite,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorPrimary),
                      // labelColor: Colors.white,
                      // unselectedLabelColor: Colors.grey,

                      indicatorColor: Colors.white,
                      labelStyle: TextStyle(
                          fontSize: 13.0.sp,
                          fontFamily: 'Amazon'), //For Selected tab
                      unselectedLabelStyle: TextStyle(
                          fontSize: 13.0.sp,
                          fontFamily: 'Amazon'), //For Un-selected Tabs

                      tabs: [
                        Tab(
                          child: Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Recently Played",
                                style: Style_File.subtitle
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Albums",
                                style: Style_File.subtitle
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Artists",
                                style: Style_File.subtitle
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
    );
  }
}
