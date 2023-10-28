import 'package:ancientmysticmusic/provider/privacyprovider.dart';
import 'package:ancientmysticmusic/provider/termsprovider.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  PrivacyProvider _privacyProvider = PrivacyProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _privacyProvider = Provider.of<PrivacyProvider>(context, listen: false);
    _privacyProvider.privacylist();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrivacyProvider>(
        builder: (context, privacyProvider, child) {
      //itemCount:  privacyList.length;

      return Scaffold(
        appBar: AppBar(title: Text("Privacy Policy")),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(1.5.h),
              child: privacyProvider.privacyList.isNotEmpty
                  ? privacyProvider.datanotfound
                      ? NoDataFoundErrorScreens(
                          height: 50.h,
                        )
                      : Text(
                          removeAllHtmlTags(
                              privacyProvider.privacyList[0].content!),
                          style: Style_File.subtitle
                              .copyWith(color: colorBlack, fontSize: 15.sp),
                        )
                  : LoaderScreens()),
        ),
      );
    });
  }
}
