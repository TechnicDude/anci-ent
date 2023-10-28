import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/library/likesonimage.dart';
import 'package:ancientmysticmusic/screen/songs/songlist.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LikedSong extends StatelessWidget {
  final MainController? con;
  final String? title;
  final List<AlbumData>? albumdata;
  const LikedSong({
    Key? key,
    this.albumdata,
    this.title,
    this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0.5.h,
        left: 2.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          if (albumdata!.isNotEmpty)
            Text("Liked Albums",
                style: Style_File.title.copyWith(color: colorPrimary)),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            height: 22.h,
            width: 100.w,
            child: ListView.builder(
              itemCount: albumdata!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<SongListProvider>(
                                    create: (BuildContext context) =>
                                        SongListProvider(),
                                    child: SongListScreens(
                                      con: con,
                                      albumdata: albumdata![index],
                                    ),
                                  )));
                    },
                    child: ClayContainer(
                      width: 32.w,
                      // height: 30.h,
                      color: colorSecondry,
                      borderRadius: 4.w,
                      spread: 1,
                      depth: 25,

                      curveType: CurveType.concave,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IMmageCallAlbumSongScreen(
                              imageurl: albumdata![index].image!),
                          Padding(
                            padding: EdgeInsets.all(1.w),
                            child: Column(
                              children: [
                                Text(albumdata![index].title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: Style_File.title
                                        .copyWith(fontSize: 14.sp)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
