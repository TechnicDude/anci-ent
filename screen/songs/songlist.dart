import 'dart:convert';
import 'dart:io';

import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/likeapi.dart';
import 'package:ancientmysticmusic/apis/paymentapi.dart';
import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/downloaddata.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/songs/myFlexiableAppBar.dart';
import 'package:ancientmysticmusic/screen/songs/songlistimage.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/premiumpopup.dart';
import 'package:ancientmysticmusic/utils/screens/addtocard.dart';
import 'package:ancientmysticmusic/utils/screens/botttom_sheet_widget.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:ancientmysticmusic/utils/utils.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongListScreens extends StatefulWidget {
  final MainController? con;
  final AlbumData albumdata;
  final Function? callback;
  const SongListScreens(
      {Key? key, required this.albumdata, this.con, this.callback})
      : super(key: key);

  @override
  State<SongListScreens> createState() => _SongListScreensState();
}

class _SongListScreensState extends State<SongListScreens> {
  SongListProvider _songListProvider = SongListProvider();

  bool searchshow = false;
  bool showpop = false;
  bool searchbarclose = false;
  String searchString = '';
  TextEditingController sercheditcontroler = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _songListProvider = Provider.of<SongListProvider>(context, listen: false);
    fetchdata();
  }

  Future fetchdata() async {
    await _songListProvider.languagelist();
    await _songListProvider.songlistlist(widget.albumdata.id!.toString(),
        _songListProvider.indexlamguage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      body: Consumer<SongListProvider>(
          builder: (context, songlistProvider, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: colorSecondry,
                  expandedHeight: 200,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: MyFlexiableAppBar(
                      image: widget.albumdata.image!,
                    ),
                    title: Text(
                      widget.albumdata.title!,
                      textAlign: TextAlign.center,
                      style: Style_File.title,
                    ),
                    centerTitle: true,
                  ),
                  actions: [
                    if (!searchshow)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            searchshow = true;
                          });
                        },
                        icon: const Icon(Icons.search),
                      ),
                    if (searchshow)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 5.h,
                          width: 90.w,
                          child: Padding(
                            padding: Style_File.edgeInsetsGeometrysubtitle,
                            child: SearchsBar(
                              textEditingController: sercheditcontroler,
                              hinttext: 'search',
                              onChanged: (value) {
                                setState(() {
                                  searchString = value;
                                });

                                if (value.isEmpty) {
                                  setState(() {
                                    searchbarclose = true;
                                    // _itemcheck();
                                  });
                                } else {
                                  setState(() {
                                    searchbarclose = false;
                                    // _itemcheck();
                                  });
                                }
                              },
                              suffixIcon: true,
                              suffixIconWidget: searchbarclose
                                  ? Icon(Icons.search)
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          sercheditcontroler.clear();
                                          searchString = '';
                                          searchbarclose = true;
                                        });
                                      },
                                      child: Icon(Icons.close)),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                buildImages(songlistProvider.songlistList, songlistProvider),
              ],
            ),
            SizedBox(
              height: 20.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  songlistProvider.shopcardList.isNotEmpty
                      ? AddToCardScreens(
                          shopcardListdata: songlistProvider.shopcartListModel,
                          con: widget.con!,
                        )
                      : SizedBox(height: 0.h),
                  if (widget.con!.audios.isNotEmpty)
                    if (songlistProvider.shopcardList.isNotEmpty)
                      SizedBox(
                        height: 5.h,
                      )
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
          ],
        );
      }),
    );
  }

  Widget buildImages(List<SongAlbumList> songalbumlist,
          SongListProvider songlistProvider) =>
      SliverToBoxAdapter(
          child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
              width: 100.w,
              child: ListView.builder(
                  itemCount: songlistProvider.languageList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          songlistProvider.indexlamguage =
                              songlistProvider.languageList[index].id!.toInt();
                          _songListProvider.songlistlist(
                              widget.albumdata.id!.toString(),
                              songlistProvider.indexlamguage.toString());
                        });

                        //                      widget.callback!("ok");
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.w),
                              color: songlistProvider.indexlamguage
                                          .toString() ==
                                      songlistProvider.languageList[index].id
                                          .toString()
                                  ? colorPrimary
                                  : colorWhite),
                          child: Padding(
                            padding: Style_File.edgeInsetsGeometryboth,
                            child: Center(
                              child: Text(
                                songlistProvider.languageList[index].name!,
                                style: Style_File.title.copyWith(
                                    color: songlistProvider.indexlamguage
                                                .toString() ==
                                            songlistProvider
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: songalbumlist.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return songalbumlist[index]
                          .title!
                          .toLowerCase()
                          .contains(searchString.toLowerCase())
                      ? Padding(
                          padding: Style_File.cardpadding,
                          child: InkWell(
                            onTap: () {
                              print("object eredf");
                              if (songalbumlist[index]
                                      .paymentdata!
                                      .toLowerCase() ==
                                  "yes") {
                                var data = {
                                  "user_id": MyApp.userid,
                                  "album_id":
                                      songalbumlist[index].albumId.toString(),
                                  "song_id": songalbumlist[index].id.toString(),
                                };
                                LikeApi likeapiadd = new LikeApi(data);
                                final response = likeapiadd.recentlyPlayedadd();
                                print(response);
                                widget.con!.playSong(
                                    widget.con!.convertToAudio(songalbumlist),
                                    songalbumlist
                                        .indexOf(songalbumlist[index]));
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IMmageCallsonlistScreen(
                                      imageurl: songalbumlist[index].image!,
                                    ),

                                    SizedBox(width: 3.w),

                                    SizedBox(
                                      width: 30.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            songalbumlist[index].title!,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: Style_File.songtitle,
                                          ),
                                          SizedBox(
                                            height: .5.h,
                                          ),
                                          Text(
                                            songalbumlist[index]
                                                .artists!
                                                .artistname!,
                                            style: Style_File.songsubtitle,
                                          ),
                                          SizedBox(
                                            height: .5.h,
                                          ),
                                          Text(
                                            '\$ ${songalbumlist[index].price.toString()}',
                                            style: Style_File.songsubtitle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Spacer(),
                                    // if (songalbumlist[index].paymentdata!.toLowerCase() ==
                                    //     "yes")

                                    InkWell(
                                        onTap: () async {
                                          if (songalbumlist[index]
                                                  .paymentdata!
                                                  .toLowerCase() ==
                                              "yes") {
                                            Utils().downloadFile(
                                              APIURL.imageurl +
                                                  songalbumlist[index].audio!,
                                              songalbumlist[index]
                                                  .audio!
                                                  .replaceAll(
                                                      "songsAudio/", ""),
                                            );
                                            print("object ok");
                                            String dir = Platform.isAndroid
                                                ? (await getExternalStorageDirectory())!
                                                    .path //FOR ANDROID
                                                : (await getApplicationSupportDirectory())
                                                    .path;
                                            String url = dir +
                                                '/' +
                                                songalbumlist[index]
                                                    .audio!
                                                    .replaceAll(
                                                        "songsAudio/", "");

                                            DownloadData downloadData =
                                                DownloadData(
                                                    id: songalbumlist[index]
                                                        .id
                                                        .toString(),
                                                    image: songalbumlist[index]
                                                        .image!,
                                                    name: songalbumlist[index]
                                                        .title,
                                                    price: songalbumlist[index]
                                                        .price,
                                                    url: url);
                                            Map<String, dynamic> data =
                                                downloadData.toJson();
                                            String data1 = jsonEncode(data);
                                            SharedPreferences
                                                sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            var datacheck = sharedPreferences
                                                .getStringList('data');
                                            List listOfFacts;
                                            bool datafind = false;
                                            if (datacheck == null) {
                                              //                         datacheck.categoriesdata[i].categoryname!
                                              // .toLowerCase()
                                              // .contains(widget.searchString.toLowerCase())
                                              List<String> data4 = [data1];
                                              await sharedPreferences
                                                  .setStringList('data', data4);
                                            } else {
                                              final json = jsonDecode(
                                                  datacheck.toString());

                                              listOfFacts = json;
                                              print("object ok data");
                                              print(listOfFacts);
                                              List<DownloadData>
                                                  downloadfinaldata =
                                                  listOfFacts
                                                      .map((tagJson) =>
                                                          DownloadData.fromJson(
                                                              tagJson))
                                                      .toList();
                                              for (int i = 0;
                                                  i < downloadfinaldata.length;
                                                  i++) {
                                                if (downloadfinaldata[i]
                                                    .id!
                                                    .toLowerCase()
                                                    .contains(
                                                        songalbumlist[index]
                                                            .id
                                                            .toString())) {
                                                  setState(() {
                                                    datafind = true;
                                                  });
                                                }
                                              }
                                              if (!datafind) {
                                                List<String> data4 = datacheck;
                                                data4.add(data1);
                                                await sharedPreferences
                                                    .setStringList(
                                                        'data', data4);
                                              }
                                            }
                                            // String data1 = '';
                                            // data1 += data;
                                            String data2 = '';
                                            //await data2.insert(0, data);
                                            data2.splitMapJoin(data1);
                                            var datacheck2 = sharedPreferences
                                                .getStringList('data');
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

                                    if (songalbumlist[index]
                                            .paymentdata!
                                            .toLowerCase() !=
                                        "yes")
                                      InkWell(
                                          onTap: () async {
                                            if (songalbumlist[index]
                                                    .paymentdata!
                                                    .toLowerCase() !=
                                                "select") {
                                              setState(() {
                                                songalbumlist[index]
                                                    .paymentdata = "select";
                                              });
                                              var bodydata = {
                                                "user_id": MyApp.userid,
                                                "price": songalbumlist[index]
                                                    .price
                                                    .toString(),
                                                "song_id": songalbumlist[index]
                                                    .id
                                                    .toString(),
                                              };

                                              PaymentApi paymentApi =
                                                  new PaymentApi(bodydata);
                                              final response =
                                                  await paymentApi.addToCart();
                                              print("object");
                                              if (response['error'] != null) {
                                                DialogHelper.showFlutterToast(
                                                    strMsg: response['error']
                                                        .toString());
                                                setState(() {
                                                  songalbumlist[index]
                                                      .paymentdata = "unselect";
                                                });
                                              }
                                              // widget.oncallback!(
                                              //     StringFile
                                              //         .select);
                                            } else {
                                              setState(() {
                                                songalbumlist[index]
                                                    .paymentdata = "unselect";
                                              });
                                              var bodydata = {
                                                "user_id": MyApp.userid,
                                                "song_id": songalbumlist[index]
                                                    .id
                                                    .toString(),
                                              };

                                              PaymentApi paymentApi =
                                                  new PaymentApi(bodydata);
                                              final response = await paymentApi
                                                  .removeToCart();
                                              print(response);
                                              // widget.oncallback!(
                                              //     StringFile
                                              //         .select);
                                            }
                                            songlistProvider.shopcard();
                                          },
                                          child: Icon(
                                            //size: 6.w,
                                            songalbumlist[index].paymentdata ==
                                                    "select"
                                                ? Icons.shopping_cart
                                                : Icons.shopping_cart_checkout,
                                            color: colorPrimary,
                                          )),
                                    SizedBox(width: 2.w),

                                    InkWell(
                                      onTap: () {
                                        if (songalbumlist[index]
                                                .paymentdata!
                                                .toLowerCase() ==
                                            "yes") {
                                          showModalBottomSheet(
                                              useRootNavigator: true,
                                              isScrollControlled: true,
                                              elevation: 100,
                                              backgroundColor: Colors.black38,
                                              context: context,
                                              builder: (context) {
                                                return BottomSheetWidget(
                                                    con: widget.con!,
                                                    isNext: true,
                                                    song: SongAlbumList(
                                                      id: int.parse(
                                                          songalbumlist[index]
                                                              .id
                                                              .toString()),
                                                      title:
                                                          songalbumlist[index]
                                                              .title,
                                                      audio:
                                                          songalbumlist[index]
                                                              .audio,
                                                      image: APIURL.imageurl +
                                                          songalbumlist[index]
                                                              .image!,
                                                      artists:
                                                          songalbumlist[index]
                                                              .artists,
                                                      albums:
                                                          songalbumlist[index]
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

                                    // InkWell(
                                    //   onTap: () {},
                                    //   child: Icon(
                                    //     Icons.more_vert_rounded,
                                    //     color: colorPrimary,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container();
                }),
            SizedBox(
              height: 10.h,
            ),
            if (songlistProvider.shopcardList.isNotEmpty)
              SizedBox(
                height: 20.h,
              ),
          ],
        ),
      ));
}
