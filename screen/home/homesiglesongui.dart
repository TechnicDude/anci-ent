import 'dart:async';

import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/likeapi.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/recentplaymodel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/songs/songlist.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeSongSinglesScreens extends StatelessWidget {
  final MainController? con;
  final List<SongAlbumList>? albumdata;

  const HomeSongSinglesScreens({Key? key, this.albumdata, this.con})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: albumdata!.length > 10 ? 10 : albumdata!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: Style_File.edgeInsetsGeometry,
              child: GestureDetector(
                onTap: () {
                  print("object");
                  var data = {
                    "user_id": MyApp.userid,
                    "song_id": albumdata![index].id.toString(),
                  };

                  // if (albumdata![index]
                  //         .albumId
                  //         .toString()
                  //         .toLowerCase()
                  //         .trim() !=
                  //     "null") {
                  //   data['album_id'] = albumdata![index].albumId.toString();
                  // }
                  LikeApi likeapiadd = new LikeApi(data);
                  final response = likeapiadd.recentlyPlayedadd();
                  // List<SongAlbumList> songdata = [];
                  // songdata.add(albumdata![index]);

                  // print(response);
                  // print(albumdata![index]);
                  con!.playSong(con!.convertToAudio(albumdata!), index);
                },
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 15.h,
                          width: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              image: DecorationImage(
                                  image: NetworkImage(APIURL.imageurl +
                                      albumdata![index].image!),
                                  fit: BoxFit.fill)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      width: 15.h,
                      child: Padding(
                        padding: Style_File.edgeInsetsGeometrysubtitle,
                        child: Text(
                          albumdata![index].title!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Style_File.subtitle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.h,
                      child: Padding(
                        padding: Style_File.edgeInsetsGeometrysubtitle,
                        child: Text(
                          "\$ ${albumdata![index].price.toString() == "null" ? "0.0" : albumdata![index].price}",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Style_File.subtitle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
