import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/recentlyplayed/recentplayedui.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecentPlayed extends StatefulWidget {
  final MainController con;
  RecentPlayed({Key? key, required this.con}) : super(key: key);

  @override
  State<RecentPlayed> createState() => _RecentPlayedState();
}

class _RecentPlayedState extends State<RecentPlayed> {
  DashBoradProvider _dashBoradProvider = DashBoradProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashBoradProvider = Provider.of<DashBoradProvider>(context, listen: false);
    _dashBoradProvider.listPlayedSong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashBoradProvider>(
          builder: (context, dashBoradProvider, child) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              color: colorPrimary,
              child: Padding(
                padding: EdgeInsets.only(top: 4.0.h),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                          Text(
                            "Recently Played",
                            style: Style_File.title
                                .copyWith(color: colorWhite, fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 60.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: colorSecondry,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.w),
                          topRight: Radius.circular(8.w))),
                  child: (dashBoradProvider.songartistList.isNotEmpty)
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0.h,
                                left: 2.0.h,
                                right: 2.0.h,
                                bottom: 4.0.h),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RecentlyPlayedUI(
                                    con: widget.con,
                                    homelistPlayedSongdata:
                                        dashBoradProvider.songartistList,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            "No data found",
                            style: Style_File.title.copyWith(
                                color: Colors.grey.shade600, fontSize: 18.sp),
                          ),
                        ),
                ),
                Positioned(
                  top: -15.h,
                  child: Image.asset(
                    ImageFile.music,
                    height: 25.h,
                  ),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
