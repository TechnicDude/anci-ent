import 'package:ancientmysticmusic/model/recentplaymodel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecentlyPlayedUI extends StatefulWidget {
  final Function? oncallback;
  final MainController con;
  final String? title;
  final List<HomelistPlayedSongData>? homelistPlayedSongdata;
  const RecentlyPlayedUI({
    Key? key,
    this.homelistPlayedSongdata,
    this.title,
    required this.con,
    this.oncallback,
  }) : super(key: key);

  @override
  State<RecentlyPlayedUI> createState() => _RecentlyPlayedUIState();
}

class _RecentlyPlayedUIState extends State<RecentlyPlayedUI> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.homelistPlayedSongdata!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: 1.h,
                bottom: 1.h,
              ),
              child: SizedBox(
                height: 12.h,
                child: ClayContainer(
                  color: colorSecondry,
                  borderRadius: 4.w,
                  curveType: CurveType.concave,
                  spread: 1,
                  depth: 25,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          IMmageCallAlbumScreen(
                              imageurl: widget.homelistPlayedSongdata![index]
                                  .songs!.image!),
                          SizedBox(
                            width: 4.w,
                          ),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 2.w,
                                ),
                                SizedBox(
                                  width: 40.w,
                                  child: Text(
                                      widget.homelistPlayedSongdata![index]
                                          .songs!.title!,
                                      //"Lorem Ipsum",
                                      style: Style_File.title
                                          .copyWith(color: colorWhite)),
                                ),
                                SizedBox(
                                  height: 2.w,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 2.2.h,
                                              color: colorPrimary,
                                            ),
                                          ),
                                          TextSpan(
                                            //  song_count
                                            text: widget
                                                .homelistPlayedSongdata![index]
                                                .songCount,

                                            style: Style_File.subtitle.copyWith(
                                                color: colorlightGrey),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                // Navigator.pop(context);
                              },
                              icon: Icon(
                                widget.homelistPlayedSongdata![index].likes
                                            .toString()
                                            .toLowerCase() ==
                                        "yes"
                                    ? Icons.favorite_sharp
                                    : Icons.favorite_border,
                                // size: 3.5.h,
                                color: colorPrimary,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
