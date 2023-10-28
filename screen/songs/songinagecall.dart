import 'package:ancientmysticmusic/apis/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SongImageScreen extends StatelessWidget {
  final String imageurl;
  const SongImageScreen({Key? key, required this.imageurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .4,
      child: CachedNetworkImage(
        imageUrl: APIURL.imageurl + imageurl,
        placeholder: (context, url) => Container(
          height: 20.w,
          width: 20.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(2.w),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );
  }
}
