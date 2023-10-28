import 'dart:convert';

import 'package:ancientmysticmusic/model/downloaddata.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/library/likesonimage.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloaduiScreen extends StatefulWidget {
  final MainController? con;
  const DownloaduiScreen({Key? key, this.con}) : super(key: key);

  @override
  State<DownloaduiScreen> createState() => _DownloaduiScreenState();
}

class _DownloaduiScreenState extends State<DownloaduiScreen> {
  List? listOfFacts;
  List<DownloadData>? finaldownloadalldata;
  Future<List<DownloadData>> retrievePayment() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String>? result = await sharedPreferences.getStringList('data');
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
    return FutureBuilder(
        future: retrievePayment(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(
                top: 0.5.h,
                left: 2.0.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Download",
                    style: Style_File.title.copyWith(color: colorPrimary),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    height: 22.h,
                    width: 100.w,
                    child: ListView.builder(
                      itemCount: finaldownloadalldata!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            print("object");
                            widget.con!.playSong(
                                widget.con!.convertToAudiolocal(
                                    finaldownloadalldata!, StringFile.loacl),
                                index);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w, right: 2.w),
                            child: ClayContainer(
                              width: 32.w,
                              // height: 30.h,
                              color: colorSecondry,
                              borderRadius: 4.w,
                              spread: 1,
                              depth: 25,

                              curveType: CurveType.concave,
                              // spread: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IMmageCallAlbumSongScreen(
                                      imageurl:
                                          finaldownloadalldata![index].image!),
                                  Padding(
                                    padding: EdgeInsets.all(1.w),
                                    child: Column(
                                      children: [
                                        Text(finaldownloadalldata![index].name!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: Style_File.title
                                                .copyWith(fontSize: 14.sp)),
                                        // SizedBox(
                                        //   height: 2.w,
                                        // ),
                                        // Text(albumdata![index].description!,
                                        //     maxLines: 2,
                                        //     overflow: TextOverflow.ellipsis,
                                        //     textAlign: TextAlign.center,
                                        //     style: Style_File.subtitle),
                                        // SizedBox(
                                        //   height: 2.w,
                                        // ),
                                        // Text("\$ ${albumdata![index].price}",
                                        //     style: Style_File.subtitle),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
