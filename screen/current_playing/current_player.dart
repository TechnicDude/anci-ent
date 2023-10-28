import 'dart:ui';

import 'package:ancientmysticmusic/apis/likeapi.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/songalbummodel.dart';
import 'package:ancientmysticmusic/model/songlistByAlbumModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/utils/player/playing_controls.dart';
import 'package:ancientmysticmusic/utils/player/position_seek_widget.dart';
import 'package:ancientmysticmusic/utils/screens/botttom_sheet_widget.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:url_launcher/url_launcher.dart';

class CurrentPlayer extends StatefulWidget {
  final MainController con;
  const CurrentPlayer({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  State<CurrentPlayer> createState() => _CurrentPlayerState();
}

class _CurrentPlayerState extends State<CurrentPlayer> {
  Future _pressed(String like, String albumid, String songid, int index) async {
    var body = {
      "user_id": MyApp.userid,
      "album_id": albumid,
      "song_id": songid,
      "likes": like,
    };
    if (like == "no") {
      LikeApi _likeapi = new LikeApi(body);
      final response = await _likeapi.likealbum();

      if (response['status'] == 'true') {
        setState(() {
          // = "yes";
        });
      }
    } else {
      LikeApi _likeapi = new LikeApi(body);
      final response = await _likeapi.dislikealbum();

      if (response['status'] == 'true') {
        setState(() {
          // widget.con.likes = "no";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ClipRRect(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: width,
        child: StreamBuilder(
          stream: widget.con.player.current,
          builder: (context, AsyncSnapshot<Playing?> snapshot) {
            if (snapshot.hasData) {
              final myAudio = widget.con
                  .find(widget.con.audios, snapshot.data!.audio.assetAudioPath);

              return ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 300, sigmaY: 300),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.black, Colors.black45],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          children: [
                                            const Text(
                                              "NOW PLAYING",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              myAudio.metas.artist!,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            useRootNavigator: true,
                                            isScrollControlled: true,
                                            elevation: 100,
                                            backgroundColor: Colors.black38,
                                            context: context,
                                            builder: (context) {
                                              return BottomSheetWidget(
                                                  con: widget.con,
                                                  isNext: true,
                                                  song: SongAlbumList(
                                                    id: int.parse(
                                                        myAudio.metas.id!),
                                                    title: myAudio.metas.title,
                                                    audio: myAudio.path,
                                                    image: myAudio
                                                        .metas.image!.path,
                                                    artists: Artists(
                                                        artistname: myAudio
                                                            .metas.artist),
                                                    albums: Albums(
                                                      title:
                                                          myAudio.metas.album,
                                                    ),
                                                  ));
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CachedNetworkImage(
                                imageUrl: myAudio.metas.image!.path,
                                fit: BoxFit.cover,
                                memCacheHeight:
                                    (200 * devicePexelRatio).round(),
                                memCacheWidth: (200 * devicePexelRatio).round(),
                                maxHeightDiskCache:
                                    (200 * devicePexelRatio).round(),
                                maxWidthDiskCache:
                                    (200 * devicePexelRatio).round(),
                                // progressIndicatorBuilder: (context, url, l) =>
                                //     const LoadingImage(
                                //   // icon: Icon(
                                //   //   LineIcons.compactDisc,
                                //   //   size: 120,
                                //   // ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Text(
                                          myAudio.metas.title!,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Text(
                                          myAudio.metas.artist!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // LikeButton(
                                //   name: myAudio.metas.title!,
                                //   fullname: myAudio.metas.artist!,
                                //   username: myAudio.metas.album!,
                                //   id: myAudio.metas.id!,
                                //   track: myAudio.path,
                                //   isIcon: false,
                                //   cover: myAudio.metas.image!.path,
                                // ),
                                const SizedBox(width: 24)
                              ],
                            ),
                            Column(children: <Widget>[
                              widget.con.player.builderRealtimePlayingInfos(
                                  builder:
                                      (context, RealtimePlayingInfos? infos) {
                                if (infos == null) {
                                  return PositionSeekWidget(
                                    currentPosition: const Duration(seconds: 0),
                                    duration:
                                        const Duration(minutes: 3, seconds: 23),
                                    seekTo: (to) {},
                                  );
                                }
                                return PositionSeekWidget(
                                  currentPosition: infos.currentPosition,
                                  duration: infos.duration,
                                  seekTo: (to) {
                                    widget.con.player.seek(to);
                                  },
                                );
                              }),
                              widget.con.player.builderLoopMode(
                                builder: (context, loopMode) {
                                  return PlayerBuilder.isPlaying(
                                      player: widget.con.player,
                                      builder: (context, isPlaying) {
                                        return PlayingControls(
                                          loopMode: loopMode,
                                          isPlaying: isPlaying,
                                          con: widget.con,
                                          isPlaylist: true,
                                          onStop: () {
                                            widget.con.player.stop();
                                          },
                                          toggleLoop: () {
                                            widget.con.player.toggleLoop();
                                          },
                                          onPlay: () {
                                            widget.con.player.playOrPause();
                                          },
                                          onNext: () {
                                            widget.con.player.next();
                                          },
                                          onPrevious: () {
                                            widget.con.player.previous();
                                          },
                                        );
                                      });
                                },
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 26.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //  IconButton(
                                    //   icon: Icon(
                                    //       widget.con.likes ==
                                    //               "yes"
                                    //           ? Icons.favorite
                                    //           : Icons.favorite_border),
                                    //   onPressed: () => _pressed(
                                    //       widget.con.likes,
                                    //       widget.con.id!,
                                    //       widget.con.user_id,

                                    //           .toString(),
                                    // ),

                                    //   iconSize: 6.w,
                                    //   color: Colors.pink,
                                    // ),

                                    InkWell(
                                      onTap: () {
                                        launchUrlString(myAudio.path);
                                      },
                                      child: const Icon(
                                        Icons.download_sharp,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   CupertinoPageRoute(
                                        //     builder: (context) =>
                                        //         PlayListWidget(
                                        //       audios: widget
                                        //           .con.player.playlist!.audios,
                                        //       con: widget.con,
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      child: const Icon(
                                        CupertinoIcons.music_note_list,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                            ]),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Text("");
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container();
          },
        ),
      ),
    );
  }
}
