import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/home/home.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecentPlaylist extends StatefulWidget {
  @override
  State<RecentPlaylist> createState() => _RecentPlaylistState();
}

class BottomList {
  BottomList(
    this.image,
    this.title,
  );

  final String image;
  final String title;
}

class _RecentPlaylistState extends State<RecentPlaylist> {
  final List<BottomList> bottomlist = [
    BottomList(
      'm4.jpg',
      "Lorem Ipsum",
    ),
    BottomList(
      'm2.jpg',
      "Lorem Ipsum1",
    ),
    BottomList(
      'm1.jpg',
      "Lorem Ipsum2",
    ),
    BottomList(
      'm2.jpg',
      "Lorem Ipsum3",
    ),
    BottomList(
      'm1.jpg',
      "Lorem Ipsum4",
    ),
    BottomList(
      'm2.jpg',
      "Lorem Ipsum5",
    ),
    BottomList(
      'm1.jpg',
      "Lorem Ipsum6",
    ),
    BottomList(
      'm2.jpg',
      "Lorem Ipsum7",
    ),
    BottomList(
      'm1.jpg',
      "Lorem Ipsum8",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      body: Padding(
        padding: EdgeInsets.only(top: 0.1.h, left: 2.0.h, right: 2.0.h),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Navigator.pushReplacementNamed(context, "/SubcategoryScreen");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 8.h,
                    child: SizedBox(
                      height: 12.h,
                      width: 12.w,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/m4.jpg'),
                        backgroundColor: colorPrimary,
                      ),
                    ),
                  ),
                  Text(bottomlist[index].title,
                      style: Style_File.title.copyWith(color: colorWhite)),
                  IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        size: 30.0,
                        color: colorPrimary,
                      )),
                ],
              ),
            );
          },
          itemCount: bottomlist.length,
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
