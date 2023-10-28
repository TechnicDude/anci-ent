import 'package:ancientmysticmusic/model/artistListModel.dart';
import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/screen/songs/songlistbyartitsScreen.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ArtistUI extends StatefulWidget {
  final MainController? con;
  final List<ArtistData>? artistdata;

  final List<LanguageModelsData> languagelist;
  const ArtistUI({
    Key? key,
    this.artistdata,
    this.con,
    required this.languagelist,
  }) : super(key: key);

  @override
  State<ArtistUI> createState() => _ArtistUIState();
}

class _ArtistUIState extends State<ArtistUI> {
  TextEditingController searchtexteditcontroll = new TextEditingController();

  String searchdata = '';
  bool searchbarclose = true;

  List<ArtistData> finalartist = [];
  bool data = false;

  Future _itemcheck() async {
    finalartist = [];
    setState(() {
      data = false;
    });
    for (int i = 0; i < widget.artistdata!.length; i++) {
      if (widget.artistdata![i].artistname!
          .trim()
          .toString()
          .toLowerCase()
          .contains(searchdata.toLowerCase())) {
        finalartist.add(widget.artistdata![i]);
      }
    }
    if (finalartist.isNotEmpty) {
      setState(() {
        data = false;
      });
    } else {
      setState(() {
        data = true;
      });
    }

    return finalartist;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Style_File.cardpadding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchsBar(
              textEditingController: searchtexteditcontroll,
              hinttext: 'search',
              onChanged: (value) {
                setState(() {
                  searchdata = value;
                });
                if (value.isEmpty) {
                  setState(() {
                    searchbarclose = true;
                    _itemcheck();
                  });
                } else {
                  setState(() {
                    searchbarclose = false;
                    _itemcheck();
                  });
                }
              },
              suffixIcon: true,
              suffixIconWidget: searchbarclose
                  ? Icon(Icons.search)
                  : InkWell(
                      onTap: () {
                        setState(() {
                          searchtexteditcontroll.clear();
                          searchdata = '';
                          searchbarclose = true;
                        });
                      },
                      child: Icon(Icons.close)),
            ),
            SizedBox(
              height: 1.h,
            ),
            data
                ? NoDataFoundErrorScreens(
                    height: 50.h,
                  )
                : ListView.builder(
                    itemCount: widget.artistdata!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return widget.artistdata![index].artistname!
                              .trim()
                              .toLowerCase()
                              .contains(
                                  searchdata.trim().toLowerCase().toString())
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider<
                                                SongListProvider>(
                                              create: (BuildContext context) =>
                                                  SongListProvider(),
                                              child: SongListByArtistScreens(
                                                con: widget.con,
                                                albumdata:
                                                    widget.artistdata![index],
                                                language: widget.languagelist,
                                              ),
                                            )));
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 2.h),
                                  SizedBox(
                                    height: 10.h,
                                    child: ClayContainer(
                                      color: colorSecondry,
                                      borderRadius: 4.w,
                                      curveType: CurveType.concave,
                                      spread: 1,
                                      depth: 25,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 1.h,
                                            bottom: 1.h,
                                            left: 1.h,
                                            right: 1.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IMmageCallAlbumScreen(
                                                imageurl: widget
                                                    .artistdata![index].image!),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      widget.artistdata![index]
                                                          .artistname!,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Style_File.title
                                                          .copyWith(
                                                              fontSize: 16.sp)),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Text(
                                                      widget.artistdata![index]
                                                          .description!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          Style_File.subtitle),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    },
                  ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
