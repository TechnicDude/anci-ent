import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class PremiumPopup extends StatelessWidget {
  final Function? callback;
  const PremiumPopup({this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            height: 22.h,
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.h)),
              border: Border.all(color: colorWhite, width: 0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 2),
                ),
              ],
              gradient: LinearGradient(
                  colors: [
                    colorSecondry,
                    colorPrimary,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      color: colorWhite,
                      onPressed: () {
                        callback!("ok");
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Text(
                  "Premium Access",
                  style: Style_File.title
                      .copyWith(color: Colors.white, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "This song is premium Access",
                  style: Style_File.title
                      .copyWith(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                // InkWell(
                //   onTap: () {
                //
                //   },
                //   child: Container(
                //     height: 5.h,
                //     width: 25.w,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(50.0)),
                //       border: Border.all(color: colorSecondry, width: 0.1),
                //       gradient: LinearGradient(
                //           colors: [
                //             const Color(0xFFd98ff9),
                //             const Color(0xFF9554fc),
                //           ],
                //           begin: const FractionalOffset(0.0, 0.0),
                //           end: const FractionalOffset(1.0, 0.0),
                //           stops: [0.0, 1.0],
                //           tileMode: TileMode.clamp),
                //     ),
                //     child: Center(
                //       child: Text(
                //         "Buy Now",
                //         style: Style_File.title
                //             .copyWith(color: Colors.white, fontSize: 16.sp),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
