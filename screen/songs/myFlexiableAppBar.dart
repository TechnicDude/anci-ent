import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/screen/songs/songinagecall.dart';
import 'package:flutter/material.dart';

class MyFlexiableAppBar extends StatelessWidget {
  final String image;
  const MyFlexiableAppBar({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SongImageScreen(
      imageurl: image,
    );
  }
}
