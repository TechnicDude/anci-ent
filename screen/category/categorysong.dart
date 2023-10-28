// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:convert';
import 'dart:io';

import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/likeapi.dart';
import 'package:ancientmysticmusic/apis/paymentapi.dart';
import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/downloaddata.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/albums/albumui.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/screen/songs/songlist.dart';
import 'package:ancientmysticmusic/screen/songs/songlistimage.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/premiumpopup.dart';
import 'package:ancientmysticmusic/utils/screens/addtocard.dart';
import 'package:ancientmysticmusic/utils/screens/botttom_sheet_widget.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:ancientmysticmusic/utils/utils.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategorySong extends StatefulWidget {
  final MainController con;
  final String? title;
  final String? id;
  const CategorySong({
    Key? key,
    this.id,
    this.title,
    required this.con,
  }) : super(key: key);

  @override
  State<CategorySong> createState() => _CategorySongState();
}

class _CategorySongState extends State<CategorySong> {
  CategoriesProvider _categoriesProvider = CategoriesProvider();
  bool showpop = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    fetchdata();
  }

  String serchdata = " ";

  Future fetchdata() async {
    await _categoriesProvider.languagelist();
    await _categoriesProvider.albumlist(
        widget.id!, _categoriesProvider.indexlamguage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: ((context, categories, child) {
        return Scaffold(
          backgroundColor: colorSecondry,
          appBar: AppBar(
            title: Text(widget.title!),
          ),
          body: Stack(
            // alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                      width: 100.w,
                      child: ListView.builder(
                          itemCount: categories.languageList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  categories.indexlamguage = categories
                                      .languageList[index].id!
                                      .toInt();
                                  categories.albumlist(widget.id!,
                                      categories.indexlamguage.toString());
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.w),
                                      color: categories.indexlamguage
                                                  .toString() ==
                                              categories.languageList[index].id
                                                  .toString()
                                          ? colorPrimary
                                          : colorWhite),
                                  child: Padding(
                                    padding: Style_File.edgeInsetsGeometryboth,
                                    child: Center(
                                      child: Text(
                                        categories.languageList[index].name!,
                                        style: Style_File.title.copyWith(
                                            color: categories.indexlamguage
                                                        .toString() ==
                                                    categories
                                                        .languageList[index].id
                                                        .toString()
                                                ? colorWhite
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    AlbumUI(
                      con: widget.con,
                      albumdata: categories.albumsList,
                      oncallback: (value) {
                        if (value == StringFile.select) {
                          categories.shopcard('0');
                        } else {
                          setState(() {
                            serchdata = value;
                          });
                        }
                      },
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.songlist.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return categories.songlist[index].title!
                                  .trim()
                                  .toLowerCase()
                                  .contains(
                                      serchdata.trim().toLowerCase().toString())
                              ? Padding(
                                  padding: Style_File.cardpadding,
                                  child: InkWell(
                                    onTap: () {
                                      // print("object eredf");
                                      if (categories
                                              .songlist[index].paymentdata!
                                              .toLowerCase() ==
                                          "yes") {
                                        var data = {
                                          "user_id": MyApp.userid.toString(),
                                          // "album_id":
                                          //     categories.songlist[index].albumId,
                                          "song_id": categories
                                              .songlist[index].id
                                              .toString(),
                                        };
                                        LikeApi likeapiadd = new LikeApi(data);
                                        final response =
                                            likeapiadd.recentlyPlayedadd();
                                        print(response);
                                        widget.con.playSong(
                                            widget.con.convertToAudio(
                                                categories.songlist),
                                            categories.songlist.indexOf(
                                                categories.songlist[index]));
                                      } else {
                                        setState(() {
                                          showpop = true;
                                        });
                                      }
                                    },
                                    child: ClayContainer(
                                      color: colorSecondry,
                                      borderRadius: 5.w,
                                      curveType: CurveType.concave,
                                      spread: 1,
                                      depth: 25,
                                      child: Padding(
                                        padding: Style_File.cardinsidepadding,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IMmageCallsonlistScreen(
                                              imageurl: categories
                                                  .songlist[index].image!,
                                            ),
                                            SizedBox(width: 3.w),
                                            SizedBox(
                                              width: 30.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    categories
                                                        .songlist[index].title!,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Style_File.songtitle,
                                                  ),
                                                  SizedBox(
                                                    height: .5.h,
                                                  ),
                                                  Text(
                                                    categories.songlist[index]
                                                        .artists!.artistname!,
                                                    style:
                                                        Style_File.songsubtitle,
                                                  ),
                                                  SizedBox(
                                                    height: .5.h,
                                                  ),
                                                  Text(
                                                    '\$ ${categories.songlist[index].price.toString().toLowerCase().trim() == "null" ? '0' : categories.songlist[index].price}',
                                                    style:
                                                        Style_File.songsubtitle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            InkWell(
                                                onTap: () async {
                                                  if (categories.songlist[index]
                                                          .paymentdata!
                                                          .toLowerCase() ==
                                                      "yes") {
                                                    Utils().downloadFile(
                                                      APIURL.imageurl +
                                                          categories
                                                              .songlist[index]
                                                              .audio!,
                                                      categories.songlist[index]
                                                          .audio!
                                                          .replaceAll(
                                                              "songsAudio/",
                                                              ""),
                                                    );
                                                    print("object ok");
                                                    String dir = Platform
                                                            .isAndroid
                                                        ? (await getExternalStorageDirectory())!
                                                            .path //FOR ANDROID
                                                        : (await getApplicationSupportDirectory())
                                                            .path;
                                                    String url = dir +
                                                        '/' +
                                                        categories
                                                            .songlist[index]
                                                            .audio!
                                                            .replaceAll(
                                                                "songsAudio/",
                                                                "");

                                                    DownloadData downloadData =
                                                        DownloadData(
                                                            id: categories
                                                                .songlist[index]
                                                                .id
                                                                .toString(),
                                                            image: categories
                                                                .songlist[index]
                                                                .image!,
                                                            name: categories
                                                                .songlist[index]
                                                                .title,
                                                            price: categories
                                                                .songlist[index]
                                                                .price,
                                                            url: url);
                                                    Map<String, dynamic> data =
                                                        downloadData.toJson();
                                                    String data1 =
                                                        jsonEncode(data);
                                                    SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    var datacheck =
                                                        await sharedPreferences
                                                            .getStringList(
                                                                'data');
                                                    List listOfFacts;
                                                    bool datafind = false;
                                                    if (datacheck == null) {
                                                      List<String> data4 = [
                                                        data1
                                                      ];
                                                      await sharedPreferences
                                                          .setStringList(
                                                              'data', data4);
                                                    } else {
                                                      final json = jsonDecode(
                                                          datacheck.toString());

                                                      listOfFacts = json;

                                                      List<DownloadData>
                                                          downloadfinaldata =
                                                          listOfFacts
                                                              .map((tagJson) =>
                                                                  DownloadData
                                                                      .fromJson(
                                                                          tagJson))
                                                              .toList();
                                                      for (int i = 0;
                                                          i <
                                                              downloadfinaldata
                                                                  .length;
                                                          i++) {
                                                        if (downloadfinaldata[i]
                                                            .id!
                                                            .toLowerCase()
                                                            .contains(categories
                                                                .songlist[index]
                                                                .id
                                                                .toString())) {
                                                          setState(() {
                                                            datafind = true;
                                                          });
                                                        }
                                                      }
                                                      if (!datafind) {
                                                        List<String> data4 =
                                                            datacheck;
                                                        data4.add(data1);
                                                        await sharedPreferences
                                                            .setStringList(
                                                                'data', data4);
                                                      }
                                                    }

                                                    String data2 = '';

                                                    await data2
                                                        .splitMapJoin(data1);
                                                    var datacheck2 =
                                                        await sharedPreferences
                                                            .getStringList(
                                                                'data');
                                                    DialogHelper.showFlutterToast(
                                                        strMsg:
                                                            "Song download successful");
                                                    print(datacheck2);
                                                  } else {
                                                    setState(() {
                                                      showpop = true;
                                                    });
                                                  }
                                                },
                                                child: Icon(
                                                  //size: 6.w,
                                                  Icons.download,
                                                  color: colorPrimary,
                                                )),
                                            SizedBox(width: 1.w),
                                            if (categories.songlist[index]
                                                    .paymentdata!
                                                    .toLowerCase() !=
                                                "yes")
                                              InkWell(
                                                  onTap: () async {
                                                    if (categories
                                                            .songlist[index]
                                                            .paymentdata!
                                                            .toLowerCase() !=
                                                        "select") {
                                                      setState(() {
                                                        categories
                                                                .songlist[index]
                                                                .paymentdata =
                                                            "select";
                                                      });
                                                      var bodydata = {
                                                        "user_id": MyApp.userid,
                                                        "price": categories
                                                            .songlist[index]
                                                            .price
                                                            .toString(),
                                                        "song_id": categories
                                                            .songlist[index].id
                                                            .toString(),
                                                      };

                                                      PaymentApi paymentApi =
                                                          new PaymentApi(
                                                              bodydata);
                                                      final response =
                                                          await paymentApi
                                                              .addToCart();
                                                      print("object");
                                                      if (response['error'] !=
                                                          null) {
                                                        DialogHelper
                                                            .showFlutterToast(
                                                                strMsg: response[
                                                                        'error']
                                                                    .toString());
                                                        setState(() {
                                                          categories
                                                                  .songlist[index]
                                                                  .paymentdata =
                                                              "unselect";
                                                        });
                                                      }
                                                      // widget.oncallback!(
                                                      //     StringFile
                                                      //         .select);
                                                    } else {
                                                      setState(() {
                                                        categories
                                                                .songlist[index]
                                                                .paymentdata =
                                                            "unselect";
                                                      });
                                                      var bodydata = {
                                                        "user_id": MyApp.userid,
                                                        "song_id": categories
                                                            .songlist[index].id
                                                            .toString(),
                                                      };

                                                      PaymentApi paymentApi =
                                                          new PaymentApi(
                                                              bodydata);
                                                      final response =
                                                          await paymentApi
                                                              .removeToCart();
                                                      print(response);
                                                      // widget.oncallback!(
                                                      //     StringFile
                                                      //         .select);
                                                    }
                                                    categories.shopcard('');
                                                  },
                                                  child: Icon(
                                                    //size: 6.w,
                                                    categories.songlist[index]
                                                                .paymentdata ==
                                                            "select"
                                                        ? Icons.shopping_cart
                                                        : Icons
                                                            .shopping_cart_checkout,
                                                    color: colorPrimary,
                                                  )),
                                            SizedBox(width: 2.w),
                                            InkWell(
                                              onTap: () {
                                                if (categories.songlist[index]
                                                        .paymentdata!
                                                        .toLowerCase() ==
                                                    "yes") {
                                                  showModalBottomSheet(
                                                      useRootNavigator: true,
                                                      isScrollControlled: true,
                                                      elevation: 100,
                                                      backgroundColor:
                                                          Colors.black38,
                                                      context: context,
                                                      builder: (context) {
                                                        return BottomSheetWidget(
                                                            con: widget.con,
                                                            isNext: true,
                                                            song: SongAlbumList(
                                                              id: int.parse(
                                                                  categories
                                                                      .songlist[
                                                                          index]
                                                                      .id
                                                                      .toString()),
                                                              title: categories
                                                                  .songlist[
                                                                      index]
                                                                  .title,
                                                              audio: categories
                                                                  .songlist[
                                                                      index]
                                                                  .audio,
                                                              image: APIURL
                                                                      .imageurl +
                                                                  categories
                                                                      .songlist[
                                                                          index]
                                                                      .image!,
                                                              artists:
                                                                  categories
                                                                      .songlist[
                                                                          index]
                                                                      .artists,
                                                              albums: categories
                                                                  .songlist[
                                                                      index]
                                                                  .albums,
                                                            ));
                                                      });
                                                } else {
                                                  setState(() {
                                                    showpop = true;
                                                  });
                                                }
                                              },
                                              child: Icon(
                                                Icons.more_vert,
                                                color: colorPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        }),
                  ],
                ),
              ),
              if (showpop)
                Center(child: PremiumPopup(
                  callback: (value) {
                    setState(() {
                      showpop = false;
                    });
                  },
                )),
              categories.shopcardList.isNotEmpty
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 20.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AddToCardScreens(
                              shopcardListdata: categories.shopcartListModel,
                              con: widget.con,
                            ),
                            if (widget.con.audios.isNotEmpty)
                              if (categories.shopcardList.isNotEmpty)
                                SizedBox(
                                  height: 5.h,
                                )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(height: 0.h)
            ],
          ),
        );
      }),
    );
  }
}
