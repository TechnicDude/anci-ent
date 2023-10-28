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

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  TermsProvider _termsProvider = TermsProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _termsProvider = Provider.of<TermsProvider>(context, listen: false);
    _termsProvider.termslist();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TermsProvider>(builder: (context, termsProvider, child) {
      //   itemCount: termsList.length;
      return Scaffold(
        appBar: AppBar(title: Text("Terms & Condition")),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(1.5.h),
            child: termsProvider.termsList.isNotEmpty
                ? termsProvider.datanotfound
                    ? NoDataFoundErrorScreens(
                        height: 50.h,
                      )
                    : Text(
                        removeAllHtmlTags(
                          termsProvider.termsList[0].content!,
                        ),
                        style: Style_File.subtitle
                            .copyWith(color: colorBlack, fontSize: 15.sp),
                      )
                : LoaderScreens(),
          ),
        ),
      );
    });
  }
}
