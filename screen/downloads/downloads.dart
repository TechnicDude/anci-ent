import 'dart:convert';

import 'package:ancientmysticmusic/model/downloaddata.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadScreen extends StatefulWidget {
  final MainController? con;
  const DownloadScreen({super.key, this.con});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  TextEditingController searchtexteditcontroll = new TextEditingController();

  bool isPressed = false;
  String searchdata = '';
  bool searchbarclose = true;
  List? listOfFacts;
  List<DownloadData>? finaldownloadalldata;
  Future<List<DownloadData>> retrievePayment() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String>? result = sharedPreferences.getStringList('data');
    print(result);
    final json = jsonDecode(result.toString());

    listOfFacts = json;

    print(
        listOfFacts!.map((tagJson) => DownloadData.fromJson(tagJson)).toList());
    finaldownloadalldata =
        listOfFacts!.map((tagJson) => DownloadData.fromJson(tagJson)).toList();

    return listOfFacts!
        .map((tagJson) => DownloadData.fromJson(tagJson))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      appBar: AppBar(title: Text("Downloads")),
      body: FutureBuilder(
          future: retrievePayment(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 0.5.h,
                  left: 2.0.h,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
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
                                    searchtexteditcontroll.clear();
                                    searchdata = '';
                                    searchbarclose = true;
                                  });
                                },
                                child: Icon(Icons.close)),
                      ),
                      ListView.builder(
                        itemCount: finaldownloadalldata!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        // physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return finaldownloadalldata![index]
                                  .name!
                                  .trim()
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchdata.toLowerCase())
                              ? InkWell(
                                  onTap: () {
                                    print("object");
                                    print(widget.con);
                                    widget.con!.playSong(
                                        widget.con!.convertToAudiolocal(
                                            finaldownloadalldata!,
                                            StringFile.loacl),
                                        index);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.w, right: 2.w, top: 2.h),
                                    child: ClayContainer(
                                      width: 32.w,
                                      // height: 30.h,
                                      color: colorSecondry,
                                      borderRadius: 4.w,
                                      spread: 1,
                                      depth: 25,

                                      curveType: CurveType.concave,
                                      // spread: 30,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IMmageCallAlbumScreen(
                                              imageurl:
                                                  finaldownloadalldata![index]
                                                      .image!),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  finaldownloadalldata![index]
                                                      .name!,
                                                  style: Style_File.title),
                                              SizedBox(
                                                height: 2.w,
                                              ),
                                              SizedBox(
                                                height: 2.w,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
