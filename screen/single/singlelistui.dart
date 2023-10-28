import 'dart:convert';
import 'dart:io';

import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/likeapi.dart';
import 'package:ancientmysticmusic/apis/paymentapi.dart';
import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/downloaddata.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/songs/songlistimage.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/premiumpopup.dart';
import 'package:ancientmysticmusic/utils/screens/addtocard.dart';
import 'package:ancientmysticmusic/utils/screens/botttom_sheet_widget.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:ancientmysticmusic/utils/utils.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleListUIScreenActivity extends StatefulWidget {
  final MainController con;
  const SingleListUIScreenActivity({
    super.key,
    required this.con,
  });

  @override
  State<SingleListUIScreenActivity> createState() =>
      _SingleListUIScreenActivityState();
}

class _SingleListUIScreenActivityState
    extends State<SingleListUIScreenActivity> {
  DashBoradProvider _dashBoradProvider = DashBoradProvider();
  String serchdata = "";
  bool searchshow = false;
  bool showpop = false;
  bool searchbarclose = false;
  @override
  void initState() {
    // TODO: implement initState
    _dashBoradProvider = Provider.of<DashBoradProvider>(context, listen: false);
    fetchdate();
    super.initState();
  }

  fetchdate() async {
    await _dashBoradProvider.singleSonglist('1');
    await _dashBoradProvider.shopcard();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoradProvider>(
        builder: (context, dashBoradProvider, child) {
      return Scaffold(
        backgroundColor: colorSecondry,
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorWhite),
          title: Text('Single'),
          backgroundColor: colorSecondry,
          // automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: dashBoradProvider.siglesonglistlist.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return dashBoradProvider.siglesonglistlist[index].title!
                                .trim()
                                .toLowerCase()
                                .contains(
                                    serchdata.trim().toLowerCase().toString())
                            ? Padding(
                                padding: Style_File.cardpadding,
                                child: InkWell(
                                  onTap: () {
                                    // print("object eredf");
                                    if (dashBoradProvider
                                            .siglesonglistlist[index]
                                            .paymentdata!
                                            .toLowerCase() ==
                                        "yes") {
                                      var data = {
                                        "user_id": MyApp.userid.toString(),
                                        // "album_id":
                                        //     categories.songlist[index].albumId,
                                        "song_id": dashBoradProvider
                                            .siglesonglistlist[index].id
                                            .toString(),
                                      };
                                      LikeApi likeapiadd = new LikeApi(data);
                                      final response =
                                          likeapiadd.recentlyPlayedadd();
                                      print(response);
                                      widget.con.playSong(
                                          widget.con.convertToAudio(
                                              dashBoradProvider
                                                  .siglesonglistlist),
                                          dashBoradProvider.siglesonglistlist
                                              .indexOf(dashBoradProvider
                                                  .siglesonglistlist[index]));
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
                                            imageurl: dashBoradProvider
                                                .siglesonglistlist[index]
                                                .image!,
                                          ),
                                          SizedBox(width: 3.w),
                                          SizedBox(
                                            width: 30.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  dashBoradProvider
                                                      .siglesonglistlist[index]
                                                      .title!,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Style_File.songtitle,
                                                ),
                                                SizedBox(
                                                  height: .5.h,
                                                ),
                                                Text(
                                                  dashBoradProvider
                                                      .siglesonglistlist[index]
                                                      .artists!
                                                      .artistname!,
                                                  style:
                                                      Style_File.songsubtitle,
                                                ),
                                                SizedBox(
                                                  height: .5.h,
                                                ),
                                                Text(
                                                  '\$ ${dashBoradProvider.siglesonglistlist[index].price.toString().toLowerCase().trim() == "null" ? '0' : dashBoradProvider.siglesonglistlist[index].price}',
                                                  style:
                                                      Style_File.songsubtitle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          InkWell(
                                              onTap: () async {
                                                if (dashBoradProvider
                                                        .siglesonglistlist[
                                                            index]
                                                        .paymentdata!
                                                        .toLowerCase() ==
                                                    "yes") {
                                                  Utils().downloadFile(
                                                    APIURL.imageurl +
                                                        dashBoradProvider
                                                            .siglesonglistlist[
                                                                index]
                                                            .audio!,
                                                    dashBoradProvider
                                                        .siglesonglistlist[
                                                            index]
                                                        .audio!
                                                        .replaceAll(
                                                            "songsAudio/", ""),
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
                                                      dashBoradProvider
                                                          .siglesonglistlist[
                                                              index]
                                                          .audio!
                                                          .replaceAll(
                                                              "songsAudio/",
                                                              "");

                                                  DownloadData
                                                      downloadData =
                                                      DownloadData(
                                                          id: dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                          image: dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
                                                              .image!,
                                                          name: dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
                                                              .title,
                                                          price: dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
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
                                                          .contains(dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
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
                                          if (dashBoradProvider
                                                  .siglesonglistlist[index]
                                                  .paymentdata!
                                                  .toLowerCase() !=
                                              "yes")
                                            InkWell(
                                                onTap: () async {
                                                  if (dashBoradProvider
                                                          .siglesonglistlist[
                                                              index]
                                                          .paymentdata!
                                                          .toLowerCase() !=
                                                      "select") {
                                                    setState(() {
                                                      dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
                                                              .paymentdata =
                                                          "select";
                                                    });
                                                    var bodydata = {
                                                      "user_id": MyApp.userid,
                                                      "price": dashBoradProvider
                                                          .siglesonglistlist[
                                                              index]
                                                          .price
                                                          .toString(),
                                                      "song_id":
                                                          dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
                                                              .id
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
                                                        dashBoradProvider
                                                                .siglesonglistlist[
                                                                    index]
                                                                .paymentdata =
                                                            "unselect";
                                                      });
                                                    }
                                                    // widget.oncallback!(
                                                    //     StringFile
                                                    //         .select);
                                                  } else {
                                                    setState(() {
                                                      dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
                                                              .paymentdata =
                                                          "unselect";
                                                    });
                                                    var bodydata = {
                                                      "user_id": MyApp.userid,
                                                      "song_id":
                                                          dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
                                                              .id
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
                                                  dashBoradProvider.shopcard();
                                                },
                                                child: Icon(
                                                  //size: 6.w,
                                                  dashBoradProvider
                                                              .siglesonglistlist[
                                                                  index]
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
                                              if (dashBoradProvider
                                                      .siglesonglistlist[index]
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
                                                                dashBoradProvider
                                                                    .siglesonglistlist[
                                                                        index]
                                                                    .id
                                                                    .toString()),
                                                            title: dashBoradProvider
                                                                .siglesonglistlist[
                                                                    index]
                                                                .title,
                                                            audio: dashBoradProvider
                                                                .siglesonglistlist[
                                                                    index]
                                                                .audio,
                                                            image: APIURL
                                                                    .imageurl +
                                                                dashBoradProvider
                                                                    .siglesonglistlist[
                                                                        index]
                                                                    .image!,
                                                            artists:
                                                                dashBoradProvider
                                                                    .siglesonglistlist[
                                                                        index]
                                                                    .artists,
                                                            albums: dashBoradProvider
                                                                .siglesonglistlist[
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
            dashBoradProvider.shopcardList.isNotEmpty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      // height: 20.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AddToCardScreens(
                            shopcardListdata:
                                dashBoradProvider.shopcartListModel,
                            con: widget.con,
                          ),
                          if (widget.con.audios.isNotEmpty)
                            if (dashBoradProvider.shopcardList.isNotEmpty)
                              SizedBox(
                                height: 5.h,
                              )
                        ],
                      ),
                    ),
                  )
                : SizedBox(height: 0.h),
          ],
        ),
      );
    });
  }
}
