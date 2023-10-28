import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DownloadsUI extends StatefulWidget {
  const DownloadsUI({super.key});

  @override
  State<DownloadsUI> createState() => _DownloadsUIState();
}

class DownloadsList {
  DownloadsList(this.image, this.title, this.subtitle);

  final String image;
  final String title;

  final String subtitle;
}

class _DownloadsUIState extends State<DownloadsUI> {
  final List<DownloadsList> downloadslist = [
    DownloadsList(
      "m2.jpg",
      "Song Name",
      "Album Name",
    ),
    DownloadsList(
      "m3.jpg",
      "Album Name",
      "Album Name",
    ),
    DownloadsList(
      "m2.jpg",
      "Song Name",
      "Album Name",
    ),
    DownloadsList(
      "m3.jpg",
      "Album Name",
      "Album Name",
    ),
    DownloadsList(
      "m2.jpg",
      "Song Name",
      "Album Name",
    ),
    DownloadsList(
      "m2.jpg",
      "Song Name",
      "Album Name",
    ),
    DownloadsList(
      "m3.jpg",
      "Album Name",
      "Album Name",
    ),
    DownloadsList(
      "m2.jpg",
      "Song Name",
      "Album Name",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.0.h, left: 2.0.h, right: 2.0.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SearchBar(
            //   text: "search",
            // ),

            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 50.h,
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ClayContainer(
                          color: colorSecondry,
                          borderRadius: 4.w,
                          curveType: CurveType.concave,
                          spread: 1,
                          depth: 25,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 15.w,
                                width: 15.w,
                                decoration: BoxDecoration(
                                  color: colorSecondry,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.w),
                                  ),
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/m4.jpg",
                                      ),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(downloadslist[index].title,
                                        style: Style_File.title
                                            .copyWith(color: colorWhite)),
                                    SizedBox(
                                      height: 2.w,
                                    ),
                                    Text(downloadslist[index].subtitle,
                                        style: Style_File.subtitle
                                            .copyWith(color: colorWhite)),
                                    // SizedBox(
                                    //   height: 2.w,
                                    // ),
                                    // Text(downloadslist[index]. image ?? '',
                                    //     style: Style_File.subtitle
                                    //         .copyWith(color: colorWhite)),
                                  ],
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.favorite_border,
                                          // size: 3.5.h,
                                          color: colorPrimary,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          // Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.more_vert_outlined,
                                          // size: 3.5.h,
                                          color: colorPrimary,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Divider(
                        //   thickness: 1,
                        //   color: colorGrey,
                        // ),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    );
                  },
                  itemCount: downloadslist.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("You might also like",
                    style: Style_File.title.copyWith(color: colorPrimary)),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
