import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MusicDownloads extends StatefulWidget {
  const MusicDownloads({super.key});

  @override
  State<MusicDownloads> createState() => _MusicDownloadsState();
}

class DownloadsList {
  DownloadsList(
      this.Srno, this.downloadedon, this.downloadetime, this.title, this.price);

  final String Srno;
  final String downloadedon;
  final String downloadetime;
  final String title;
  final String price;
}

class _MusicDownloadsState extends State<MusicDownloads> {
  final List<DownloadsList> downloadslist = [
    DownloadsList(
      "1",
      "01-06-22",
      "12 06",
      "Song Name",
      "\$105",
    ),
    DownloadsList(
      "2",
      "02-06-22",
      "12 06",
      "Song Name",
      "\$106",
    ),
    DownloadsList(
      "3",
      "03-06-22",
      "12 06",
      "Song Name",
      "\$107",
    ),
    DownloadsList(
      "4",
      "04-06-22",
      "12 06",
      "Song Name",
      "\$108",
    ),
    DownloadsList(
      "5",
      "05-06-22",
      "12 06",
      "Lorem Ipsum4",
      "\$109",
    ),
    DownloadsList(
      "6",
      "06-06-22",
      "12 06",
      "Lorem Ipsum5",
      "\$110",
    ),
    DownloadsList(
      "7",
      "07-06-22",
      "12 06",
      "Lorem Ipsum6",
      "\$111",
    ),
    DownloadsList(
      "8",
      "08-06-22",
      "12 06",
      "Lorem Ipsum7",
      "\$112",
    ),
    DownloadsList(
      "6",
      "06-06-22",
      "12 06",
      "Lorem Ipsum5",
      "\$110",
    ),
    DownloadsList(
      "7",
      "07-06-22",
      "12 06",
      "Lorem Ipsum6",
      "\$111",
    ),
    DownloadsList(
      "8",
      "08-06-22",
      "12 06",
      "Lorem Ipsum7",
      "\$112",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,

//body section

      body: Container(
        height: 94.h,
        child: Padding(
          padding: EdgeInsets.all(0.5.h),
          child: SingleChildScrollView(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, "/SubcategoryScreen");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(downloadslist[index].Srno,
                          style:
                              Style_File.subtitle.copyWith(color: colorWhite)),
                      Text(downloadslist[index].downloadedon,
                          style:
                              Style_File.subtitle.copyWith(color: colorWhite)),
                      // Container(
                      //   child: Text(downloadslist[index].downloadetime ?? '',
                      //       style: Style_File.subtitle
                      //           .copyWith(color: colorWhite)),
                      // ),
                      Text(downloadslist[index].title,
                          style:
                              Style_File.subtitle.copyWith(color: colorWhite)),
                      Text(downloadslist[index].price,
                          style:
                              Style_File.subtitle.copyWith(color: colorWhite)),
                      IconButton(
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.play_arrow,
                            size: 24.0,
                            color: colorWhite,
                          )),

                      IconButton(
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            size: 20.0,
                            color: colorWhite,
                          )),
                    ],
                  ),
                );
              },
              itemCount: downloadslist.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ),
      ),
    );
  }
}
