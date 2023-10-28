import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlayScreens extends StatelessWidget {
  final MainController con;
  final void Function()? onTap;
  const PlayScreens({
    Key? key,
    required this.con,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return con.player.builderCurrent(builder: (context, playing) {
      return ClayContainer(
        width: 100.w,
        height: 8.h,
        color: colorSecondry,
        borderRadius: 4.w,
        curveType: CurveType.concave,
        spread: 1,
        depth: 25,
        child: Row(
          children: [
            PlayerBuilder.isPlaying(
                player: con.player,
                builder: (context, isPlaying) {
                  return IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      con.player.playOrPause();
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 36,
                    ),
                  );
                })
          ],
        ),
      );
    });
  }
}
