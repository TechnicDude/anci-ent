import 'package:ancientmysticmusic/apis/likeapi.dart';
import 'package:ancientmysticmusic/apis/paymentapi.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/screen/songs/songlist.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AlbumUI extends StatefulWidget {
  final Function? oncallback;
  final MainController con;
  final String? title;

  final List<AlbumData>? albumdata;

  const AlbumUI({
    Key? key,
    this.albumdata,
    this.title,
    required this.con,
    this.oncallback,
  }) : super(key: key);

  @override
  State<AlbumUI> createState() => _AlbumUIState();
}

class _AlbumUIState extends State<AlbumUI> {
  TextEditingController searchtexteditcontroll = new TextEditingController();

  bool isPressed = false;
  String searchdata = '';
  bool searchbarclose = true;

  Future _pressed(String like, String albumid, int index) async {
    var body = {
      "user_id": MyApp.userid,
      "album_id": albumid,
      "song_id": '',
    };

    if (like == "no") {
      LikeApi _likeapi = new LikeApi(body);
      final response = await _likeapi.likealbum();

      if (response['status'] == 'true') {
        setState(() {
          widget.albumdata![index].likes = "yes";
        });
      }
    } else {
      LikeApi _likeapi = new LikeApi(body);
      final response = await _likeapi.dislikealbum();

      if (response['status'] == 'true') {
        setState(() {
          widget.albumdata![index].likes = "no";
        });
      }
    }
  }

  List<AlbumData> finalalbum = [];
  bool data = false;

  Future _itemcheck() async {
    finalalbum = [];
    setState(() {
      data = false;
    });

    for (int i = 0; i < widget.albumdata!.length; i++) {
      if (widget.albumdata![i].title!
          .trim()
          .toString()
          .toLowerCase()
          .contains(searchdata.toLowerCase())) {
        finalalbum.add(widget.albumdata![i]);
      }
    }
    if (finalalbum.isNotEmpty) {
      setState(() {
        data = false;
      });
    } else {
      setState(() {
        data = true;
      });
    }
    return finalalbum;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
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
                    widget.oncallback!(searchdata);
                    // widget.oncallback!(data.toString());
                  });
                } else {
                  setState(() {
                    searchbarclose = false;
                    _itemcheck();
                    widget.oncallback!(searchdata);
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
                          _itemcheck();
                        });
                      },
                      child: Icon(Icons.close)),
            ),

            SizedBox(
              height: 1.h,
            ),
            // if (finalalbum.isEmpty) Text("data"),
            ListView.builder(
              itemCount: widget.albumdata!.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return widget.albumdata![index].title!
                        .trim()
                        .toLowerCase()
                        .contains(searchdata.trim().toLowerCase().toString())
                    ? GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, Routes.songlistScreen,
                          //     arguments: {
                          //       StringFile.albumdata: widget.albumdata![index],
                          //     });
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider<SongListProvider>(
                                        create: (BuildContext context) =>
                                            SongListProvider(),
                                        child: SongListScreens(
                                          con: widget.con,
                                          albumdata: widget.albumdata![index],
                                        ),
                                      )));
                        },
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),

                            ClayContainer(
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
                                        imageurl:
                                            widget.albumdata![index].image!),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 45.w,
                                          child: Text(
                                              widget.albumdata![index].title!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Style_File.title),
                                        ),
                                        SizedBox(
                                          height: 2.w,
                                        ),
                                        Text(
                                            "\$ ${widget.albumdata![index].price!.toString()}",
                                            style: Style_File.subtitle),
                                      ],
                                    ),
                                    Spacer(),
                                    if (widget.albumdata![index].payment_data!
                                            .toLowerCase() ==
                                        "yes")
                                      IconButton(
                                        icon: Icon(
                                            widget.albumdata![index].likes ==
                                                    "yes"
                                                ? Icons.favorite
                                                : Icons.favorite_border),
                                        onPressed: () => _pressed(
                                            widget.albumdata![index].likes!,
                                            widget.albumdata![index].id!
                                                .toString(),
                                            index),
                                        iconSize: 6.w,
                                        color: Colors.pink,
                                      ),
                                    if (widget.albumdata![index].payment_data!
                                            .toLowerCase() !=
                                        "yes")
                                      IconButton(
                                        icon: Icon(
                                          widget.albumdata![index].payment_data!
                                                      .toLowerCase() ==
                                                  "select"
                                              ? Icons.shopping_cart
                                              : Icons.shopping_cart_checkout,
                                        ),
                                        onPressed: () async {
                                          if (widget.albumdata![index]
                                                  .payment_data!
                                                  .toLowerCase() !=
                                              "select") {
                                            setState(() {
                                              widget.albumdata![index]
                                                  .payment_data = "select";
                                            });
                                            var bodydata = {
                                              "user_id": MyApp.userid,
                                              "price": widget
                                                  .albumdata![index].price
                                                  .toString(),
                                              "album_id": widget
                                                  .albumdata![index].id
                                                  .toString(),
                                            };

                                            PaymentApi paymentApi =
                                                new PaymentApi(bodydata);
                                            final response =
                                                await paymentApi.addToCart();
                                            print(response);
                                            widget
                                                .oncallback!(StringFile.select);
                                          } else {
                                            setState(() {
                                              widget.albumdata![index]
                                                  .payment_data = "unselect";
                                            });
                                            var bodydata = {
                                              "user_id": MyApp.userid,
                                              "album_id": widget
                                                  .albumdata![index].id
                                                  .toString(),
                                            };

                                            PaymentApi paymentApi =
                                                new PaymentApi(bodydata);
                                            final response =
                                                await paymentApi.removeToCart();
                                            print(response);
                                            widget
                                                .oncallback!(StringFile.select);
                                          }
                                        },
                                        iconSize: 6.w,
                                        color: Colors.pink,
                                      ),
                                    SizedBox(
                                      width: 2.w,
                                    )
                                  ],
                                ),
                              ),
                            ),

                            //   Divider(
                            //     thickness: 1,
                            //     color: colorGrey,
                            //   ),
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
