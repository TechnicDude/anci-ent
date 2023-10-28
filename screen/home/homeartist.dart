import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/artistListModel.dart';
import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/songs/songlistbyartitsScreen.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeArtistsScreens extends StatelessWidget {
  final MainController? con;
  final List<ArtistData>? artistdata;
  final List<LanguageModelsData> languagelist;
  const HomeArtistsScreens({
    Key? key,
    this.artistdata,
    this.con,
    required this.languagelist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: artistdata!.length > 10 ? 10 : artistdata!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: Style_File.edgeInsetsGeometry,
            child: GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, Routes.songlistbyartistScreen,
                //     arguments: {
                //       StringFile.albumdata: artistdata![index],
                //     });

                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<SongListProvider>(
                              create: (BuildContext context) =>
                                  SongListProvider(),
                              child: SongListByArtistScreens(
                                con: con,
                                albumdata: artistdata![index],
                                language: languagelist,
                              ),
                            )));
              },
              child: Column(
                children: [
                  Container(
                    height: 12.h,
                    width: 12.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(color: Colors.white54, width: 5),
                        // borderRadius: BorderRadius.circular(1.h),
                        image: DecorationImage(
                            image: NetworkImage(
                                APIURL.imageurl + artistdata![index].image!),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 15.h,
                    child: Padding(
                      padding: Style_File.edgeInsetsGeometrysubtitle
                          .copyWith(right: .5.w),
                      child: Text(
                        artistdata![index].artistname!,
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
        });
  }
}
