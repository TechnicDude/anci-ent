import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CouponsShowScreen extends StatefulWidget {
  final Function? callback;
  const CouponsShowScreen({Key? key, this.callback}) : super(key: key);

  @override
  State<CouponsShowScreen> createState() => _CouponsShowScreenState();
}

class _CouponsShowScreenState extends State<CouponsShowScreen> {
  CategoriesProvider _categoriesProvider = CategoriesProvider();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    _categoriesProvider.coupon();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
        builder: (context, couponProvider, child) {
      return Scaffold(
        backgroundColor: colorSecondry,
        appBar: AppBar(
          title: Text('Coupons'),
        ),
        body: ListView.builder(
            itemCount: couponProvider.couponcardList.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: Style_File.cardinsidepadding,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    widget.callback!(
                        couponProvider.couponcardList[index].couponCode!);
                  },
                  child: ClayContainer(
                    color: colorSecondry,
                    borderRadius: 2.w,
                    curveType: CurveType.concave,
                    spread: 1,
                    depth: 25,
                    child: Padding(
                      padding: Style_File.cardinsidepadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            couponProvider.couponcardList[index].couponName!,
                            style: Style_File.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}
