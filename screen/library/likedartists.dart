import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/model/artistListModel.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LikedArtists extends StatelessWidget {
  final List<ArtistData>? artistdata;
  const LikedArtists({Key? key, this.artistdata}) : super(key: key);

  // const LikedArtists({super.key, required List<ArtistData> artistdata});

  // final List<LikedartistsList> likedartistslist = [
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.0.h, left: 2.0.h, right: 2.0.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Liked Artists",
                    style: Style_File.title.copyWith(color: colorPrimary)),
              ],
            ),

            SizedBox(
              height: 27.h,
              child: ListView.builder(
                itemCount: artistdata!.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(height: 2.h),

                      ClayContainer(
                        color: colorSecondry,
                        borderRadius: 4.w,

                        curveType: CurveType.concave,
                        // spread: 30,
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              IMmageCallAlbumScreen(
                                  imageurl: artistdata![index].image!),
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(artistdata![index].artistname!,
                                      style: Style_File.title),
                                  SizedBox(
                                    height: 2.w,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 20.w,
                                child: InkWell(
                                    // iconSize: .5.w,
                                    onTap: () {
                                      // Navigator.pop(context);
                                      print("object");
                                    },
                                    child: Icon(
                                      size: 7.w,
                                      Icons.favorite,
                                      color: colorPrimary,
                                    )),
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
                  );
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),

            // SizedBox(
            //  height: 30.h,
            //   child: ListView.builder(
            //     // padding: EdgeInsets.zero,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Column(
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
            //             child: Row(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 // Container(
            //                 //   height: 16.w,
            //                 //   width: 16.w,

            //                 SizedBox(
            //                   width: 5.w,
            //                 ),
            //                 ClayContainer(
            //                   color: colorSecondry,
            //                   borderRadius: 4.w,

            //                   curveType: CurveType.concave,

            //                   child: IMmageCallAlbumScreen(
            //                       imageurl: artistdata![index].image!),

            //                   // decoration: BoxDecoration(
            //                   //     borderRadius: BorderRadius.circular(1.h),
            //                   //     image: DecorationImage(
            //                   //         image: NetworkImage(APIURL.imageurl +
            //                   //             artistdata![index].image!),
            //                   //         fit: BoxFit.fill)),

            //                   // decoration: BoxDecoration(
            //                   //     color: colorWhite,
            //                   //     borderRadius: BorderRadius.all(
            //                   //       Radius.circular(2.w),
            //                   //     ),
            //                   //     image: DecorationImage(
            //                   //       image: NetworkImage(APIURL.imageurl +
            //                   //           artistdata![index].image!),

            //                   //     )
            //                   //     // image: const DecorationImage(
            //                   //     //     image: AssetImage(
            //                   //     //       "assets/images/artist.jpg",
            //                   //     //     ),
            //                   //     //     fit: BoxFit.fill),

            //                   //     ),
            //                 ),
            //                 SizedBox(
            //                   width: 3.w,
            //                 ),
            //                 Text(artistdata![index].artistname!,
            //                     //likedartistslist[index].title,
            //                     style:
            //                         Style_File.title.copyWith(color: colorWhite)),
            //                 Spacer(),
            //                 Icon(
            //                   Icons.favorite,
            //                   size: 2.5.h,
            //                   color: colorPrimary,
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Divider(
            //             thickness: 1,
            //             color: colorGrey,
            //           ),
            //         ],
            //       );
            //     },
            //     itemCount: artistdata!.length,
            //     shrinkWrap: true,
            //     physics: const BouncingScrollPhysics(),
            //   ),
            // ),
            // SizedBox(
            //   height: 1.h,
            // ),
          ],
        ),
      ),
    );
  }
}
