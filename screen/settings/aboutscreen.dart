import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/provider/aboutprovider.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  AboutProvider _aboutProvider = AboutProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _aboutProvider = Provider.of<AboutProvider>(context, listen: false);
    _aboutProvider.aboutlist();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AboutProvider>(builder: (context, aboutProvider, child) {
      // itemCount:  aboutList.length;
      return Scaffold(
        appBar: AppBar(title: Text("About Us")),
        body: Padding(
            padding: EdgeInsets.all(1.5.h),
            child: aboutProvider.aboutList.isNotEmpty
                ? aboutProvider.datanotfound
                    ? NoDataFoundErrorScreens(
                        height: 50.h,
                      )
                    : Column(
                        children: [
                          Container(
                            height: 12.h,
                            width: 12.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white54, width: 5),
                                // borderRadius: BorderRadius.circular(1.h),
                                image: DecorationImage(
                                    image: NetworkImage(APIURL.imageurl +
                                        aboutProvider.aboutList[0].image!),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            removeAllHtmlTags(
                              aboutProvider.aboutList[0].content!,
                            ),
                            style: Style_File.subtitle
                                .copyWith(color: colorBlack, fontSize: 15.sp),
                          )
                        ],
                      )
                : LoaderScreens()),
      );
    });
  }
}
