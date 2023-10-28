import 'dart:ui';

import 'package:ancientmysticmusic/model/artistListModel.dart';
import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/screen/artists/artistscreen.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ArtistSearch extends StatelessWidget {
  final List<ArtistData>? artistdata;
  final MainController con;
  final List<LanguageModelsData> languagelist;
  const ArtistSearch({
    Key? key,
    this.artistdata,
    required this.con,
    required this.languagelist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: artistdata!.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<DashBoradProvider>(
                          create: (BuildContext context) => DashBoradProvider(),
                          child: ArtistScreen(
                            con: con,
                            languagelist: languagelist,
                            // artistdata: artistdata![index],
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
                          width: 4.w,
                        ),
                        IMmageCallAlbumScreen(
                            imageurl: artistdata![index].image!),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(artistdata![index].artistname!,
                            style: Style_File.title),
                        // Spacer(),
                        // InkWell(
                        //     onTap: () {},
                        //     child: Icon(
                        //       size: 6.w,
                        //       Icons.favorite_border,
                        //       color: colorPrimary,
                        //     )),
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
