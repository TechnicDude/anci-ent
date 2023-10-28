import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/screen/songs/songlist.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/style_file.dart';

class AlbumSearch extends StatelessWidget {
  final List<AlbumData>? albumdata;
  final MainController con;
  const AlbumSearch({Key? key, this.albumdata, required this.con})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: albumdata!.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<SongListProvider>(
                          create: (BuildContext context) => SongListProvider(),
                          child: SongListScreens(
                            con: con,
                            albumdata: albumdata![index],
                          ),
                        )));
          },
          child: Column(
            children: [
              SizedBox(height: 2.h),
              SizedBox(
                height: 8.h,
                child: ClayContainer(
                  color: colorSecondry,
                  borderRadius: 4.w,
                  curveType: CurveType.concave,
                  spread: 1,
                  depth: 25,
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        IMmageCallAlbumScreen(
                            imageurl: albumdata![index].image!),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(albumdata![index].title!,
                                style: Style_File.title),
                            SizedBox(
                              height: 2.w,
                            ),
                            Text("\$ ${albumdata![index].price!.toString()}.00",
                                style: Style_File.subtitle
                                    .copyWith(fontSize: 12.sp)),
                          ],
                        ),
                        SizedBox(
                          width: 2.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
