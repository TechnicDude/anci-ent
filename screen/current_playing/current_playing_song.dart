// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';

import 'package:ancientmysticmusic/model/songalbummodel.dart';
import 'package:ancientmysticmusic/model/songlistByAlbumModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/player/playing_controls.dart';
import 'package:ancientmysticmusic/utils/player/position_seek_widget.dart';
import 'package:ancientmysticmusic/utils/screens/botttom_sheet_widget.dart';
import 'package:ancientmysticmusic/utils/screens/buttontapped.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:url_launcher/url_launcher.dart';

class CurrentPlayingSong extends StatelessWidget {
  final MainController con;
  const CurrentPlayingSong({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    return Container(
        child: con.player.builderCurrent(builder: (context, playing) {
      if (playing != null) {
        final myAudio = con.find(con.audios, playing.audio.assetAudioPath);

        return Container(
          color: colorSecondry,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
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
                            vertical: 16.0, horizontal: 12),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ButtonTapped(
                                icon: Icons.arrow_back_ios,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "NOW PLAYING",
                                      style: Style_File.subtitle,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      myAudio.metas.artist!,
                                      style: Style_File.songsubtitle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    elevation: 100,
                                    backgroundColor: Colors.black38,
                                    context: context,
                                    builder: (context) {
                                      return BottomSheetWidget(
                                          con: con,
                                          isNext: true,
                                          song: SongAlbumList(
                                            id: int.parse(myAudio.metas.id!),
                                            title: myAudio.metas.title,
                                            audio: myAudio.path,
                                            image: myAudio.metas.image!.path,
                                            artists: Artists(
                                                artistname:
                                                    myAudio.metas.artist),
                                            albums: Albums(
                                              title: myAudio.metas.album,
                                            ),
                                          ));
                                    });
                              },
                              child: ButtonTapped(
                                icon: Icons.more_vert,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.w),
                      child: CachedNetworkImage(
                        imageUrl: myAudio.metas.image!.path,
                        height: 40.h,
                        width: 100.w,
                        // memCacheHeight: (10 * devicePexelRatio).round(),
                        // memCacheWidth: (10 * devicePexelRatio).round(),
                        // maxHeightDiskCache: (10 * devicePexelRatio).round(),
                        // maxWidthDiskCache: (10 * devicePexelRatio).round(),
                        // progressIndicatorBuilder: (context, url, l) =>
                        //     const LoadingImage(
                        //   icon: Icon(
                        //     LineIcons.compactDisc,
                        //     size: 120,
                        //   ),
                        // ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Text(myAudio.metas.title!,
                      maxLines: 1, style: Style_File.title),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Text(
                    myAudio.metas.artist!,
                    style: Style_File.subtitle.copyWith(color: Colors.grey),
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LikeButton(
                    //   name: myAudio.metas.title!,
                    //   fullname: myAudio.metas.artist!,
                    //   username: myAudio.metas.album!,
                    //   id: myAudio.metas.id!,
                    //   track: myAudio.path,
                    //   isIcon: false,
                    //   cover: myAudio.metas.image!.path,
                    // ),

                    Column(children: <Widget>[
                      con.player.builderRealtimePlayingInfos(
                          builder: (context, RealtimePlayingInfos? infos) {
                        if (infos == null) {
                          return const SizedBox();
                        }
                        return PositionSeekWidget(
                          currentPosition: infos.currentPosition,
                          duration: infos.duration,
                          seekTo: (to) {
                            con.player.seek(to);
                          },
                        );
                      }),
                      con.player.builderLoopMode(
                        builder: (context, loopMode) {
                          return PlayerBuilder.isPlaying(
                              player: con.player,
                              builder: (context, isPlaying) {
                                return PlayingControls(
                                  loopMode: loopMode,
                                  isPlaying: isPlaying,
                                  con: con,
                                  isPlaylist: true,
                                  onStop: () {
                                    con.player.stop();
                                  },
                                  toggleLoop: () {
                                    con.player.toggleLoop();
                                  },
                                  onPlay: () {
                                    con.player.playOrPause();
                                  },
                                  onNext: () {
                                    con.player.next();
                                  },
                                  onPrevious: () {
                                    con.player.previous();
                                  },
                                );
                              });
                        },
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                launch(myAudio.path);
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
                                //     builder: (context) => PlayListWidget(
                                //       audios: con.player.playlist!.audios,
                                //       con: con,
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
        );
      } else {
        return Container();
      }
    }));
  }
}
