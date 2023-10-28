import 'dart:convert';
import 'dart:io';

import 'package:ancientmysticmusic/apis/addplaylist.dart';
import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/downloaddata.dart';
import 'package:ancientmysticmusic/model/songlistByAlbumModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/utils.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loading.dart';

class BottomSheetWidget extends StatelessWidget {
  final MainController con;
  final bool? isNext;
  final SongAlbumList song;
  const BottomSheetWidget({
    Key? key,
    required this.con,
    this.isNext,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    return Padding(
      padding: EdgeInsets.only(left: 3.w, right: 3.w),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
            color: colorSecondry,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.w),
              topRight: Radius.circular(4.w),
            )),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * .2,
                // ),

                Text(
                  song.title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  song.artists!.artistname!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 20),
                // LikeButton(
                //   id: song.songid!,
                //   isIcon: true,
                //   cover: song.coverImageUrl!,
                //   fullname: song.name!,
                //   name: song.songname!,
                //   track: song.trackid!,
                //   username: song.userid!,
                // ),
                if (isNext == null)
                  ListTile(
                    onTap: () {
                      var title = con.player.getCurrentAudioTitle;
                      Audio currentSong =
                          con.findByname(con.player.playlist!.audios, title);
                      int currentIndex =
                          con.player.playlist!.audios.indexOf(currentSong);
                      con.player.playlist!.insert(
                          currentIndex + 1, con.convertToAudio([song])[0]);
                      // context.showSnackBar(message: "Added to Queue");
                      Navigator.pop(context);
                    },
                    minLeadingWidth: 30,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    leading: const Icon(
                      CupertinoIcons.play_arrow,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Play Next",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 15.sp, color: Colors.white),
                    ),
                  ),
                ListTile(
                  onTap: () {
                    con.player.playlist!.add(con.convertToAudio([song])[0]);
                    // context.showSnackBar(message: "Added to Queue");
                    Navigator.pop(context);
                    DialogHelper.showFlutterToast(strMsg: "Added to Queue ");
                  },
                  minLeadingWidth: 30,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  leading: const Icon(
                    Icons.playlist_add,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Add To queue",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    // Navigator.push(context,
                    //     CupertinoPageRoute(builder: (BuildContext context) {
                    //   return AddToPlaylist(
                    //     id: song.songid!,
                    //     cover: song.coverImageUrl!,
                    //     fullname: song.name!,
                    //     name: song.songname!,
                    //     track: song.trackid!,
                    //     username: song.userid!,
                    //   );
                    // }));
                    var body = {
                      "user_id": MyApp.userid,
                      "name": song.title,
                      "song_id": song.id.toString(),
                    };
                    AddPlayListApi addPlayListApi = AddPlayListApi(body);
                    final response = await addPlayListApi.addToPlaylist();
                    if (response['status'] == "true") {
                      DialogHelper.showFlutterToast(
                          strMsg: response['message']);
                      Navigator.pop(context);
                    } else {
                      DialogHelper.showFlutterToast(strMsg: response['error']);
                      Navigator.pop(context);
                    }
                  },
                  minLeadingWidth: 30,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  leading: const Icon(
                    CupertinoIcons.music_albums,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Add to Playlist",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    // launch(song.trackid!);
                    Utils().downloadFile(
                      APIURL.imageurl + song.audio!,
                      song.audio!.replaceAll("songsAudio/", ""),
                    );
                    print("object ok");
                    String dir = Platform.isAndroid
                        ? (await getExternalStorageDirectory())!
                            .path //FOR ANDROID
                        : (await getApplicationSupportDirectory()).path;
                    String url =
                        dir + '/' + song.audio!.replaceAll("songsAudio/", "");
                    print("object image ${song.image!}");
                    DownloadData downloadData = DownloadData(
                        id: song.id.toString(),
                        image: song.image!
                            .replaceAll("${APIURL.ROOT + '/storage/'}", ""),
                        name: song.title,
                        price: song.price,
                        url: url);
                    Map<String, dynamic> data = downloadData.toJson();
                    String data1 = jsonEncode(data);
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    var datacheck =
                        await sharedPreferences.getStringList('data');
                    List listOfFacts;
                    bool datafind = false;
                    if (datacheck == null) {
                      //                         datacheck.categoriesdata[i].categoryname!
                      // .toLowerCase()
                      // .contains(widget.searchString.toLowerCase())
                      List<String> data4 = [data1];
                      await sharedPreferences.setStringList('data', data4);
                    } else {
                      final json = jsonDecode(datacheck.toString());

                      listOfFacts = json;
                      print("object ok data");
                      print(listOfFacts);
                      List<DownloadData> downloadfinaldata = listOfFacts
                          .map((tagJson) => DownloadData.fromJson(tagJson))
                          .toList();
                      for (int i = 0; i < downloadfinaldata.length; i++) {
                        if (downloadfinaldata[i]
                            .id!
                            .toLowerCase()
                            .contains(song.id.toString())) {
                          // setState(() {
                          datafind = true;
                          // });
                        }
                      }
                      if (!datafind) {
                        List<String> data4 = datacheck;
                        data4.add(data1);
                        await sharedPreferences.setStringList('data', data4);
                      }
                    }
                    // String data1 = '';
                    // data1 += data;
                    String data2 = '';
                    //await data2.insert(0, data);
                    await data2.splitMapJoin(data1);
                    var datacheck2 =
                        await sharedPreferences.getStringList('data');
                    DialogHelper.showFlutterToast(
                        strMsg: "Song download successful");
                    print(datacheck2);
                  },
                  minLeadingWidth: 30,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  leading: const Icon(
                    Icons.download,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "Download",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            Positioned(
              top: -100,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: song.image!,
                        memCacheHeight: (300 * devicePexelRatio).round(),
                        memCacheWidth: (300 * devicePexelRatio).round(),
                        maxHeightDiskCache: (300 * devicePexelRatio).round(),
                        maxWidthDiskCache: (300 * devicePexelRatio).round(),
                        progressIndicatorBuilder: (context, url, l) =>
                            const LoadingImage(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Container(
                    //   height: 40,
                    //   decoration: const BoxDecoration(
                    //     color: colorSecondry,
                    //   ),
                    //   child: Row(
                    //     children: const [
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Icon(
                    //         Icons.music_note,
                    //         color: Colors.white,
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Text("Listen on Musive",
                    //           style: TextStyle(color: Colors.white)),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
