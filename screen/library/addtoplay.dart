import 'package:ancientmysticmusic/apis/likeapi.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/addplaylistModel.dart';
import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/library/likesonimage.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddPlayListui extends StatelessWidget {
  final MainController? con;
  final String? title;
  final List<ListPlayData>? albumdata;
  const AddPlayListui({Key? key, this.albumdata, this.title, this.con})
      : super(key: key);

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
            Text("Playlist",
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
                      print("object");
                      var data = {
                        "user_id": MyApp.userid,
                        "album_id": albumdata![index].albumId.toString(),
                        "song_id": albumdata![index].id.toString(),
                      };
                      LikeApi likeapiadd = new LikeApi(data);
                      final response = likeapiadd.recentlyPlayedadd();
                      List<SongAlbumList> songdata = [];
                      songdata.add(albumdata![index].songs!);

                      print(response);
                      print(albumdata![index]);
                      con!.playSong(con!.convertToAudio(songdata), index);
                    },
                    child: ClayContainer(
                      width: 32.w,
                      // height: 30.h,
                      color: colorSecondry,
                      borderRadius: 4.w,
                      spread: 1,
                      depth: 25,

                      curveType: CurveType.concave,
                      // spread: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IMmageCallAlbumSongScreen(
                              imageurl: albumdata![index].songs!.image!),
                          Padding(
                            padding: EdgeInsets.all(1.w),
                            child: Column(
                              children: [
                                Text(albumdata![index].songs!.title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: Style_File.title
                                        .copyWith(fontSize: 14.sp)),
                                // SizedBox(
                                //   height: 2.w,
                                // ),
                                // Text(albumdata![index].description!,
                                //     maxLines: 2,
                                //     overflow: TextOverflow.ellipsis,
                                //     textAlign: TextAlign.center,
                                //     style: Style_File.subtitle),
                                // SizedBox(
                                //   height: 2.w,
                                // ),
                                // Text("\$ ${albumdata![index].price}",
                                //     style: Style_File.subtitle),
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
