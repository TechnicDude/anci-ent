import 'package:ancientmysticmusic/model/shopcardmodel.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/utils/button_widget.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/screens/payment/addcartdesign.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddToCardScreens extends StatelessWidget {
  final ShopcartListModel? shopcardListdata;
  final MainController con;
  const AddToCardScreens({
    Key? key,
    this.shopcardListdata,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: ClayContainer(
        width: 90.w,
        borderRadius: 2.w,
        height: 10.h,
        color: colorSecondry,
        // parentColor: Color,
        // emboss: true,
        spread: 1,
        depth: 25,
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Column(
            children: [
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${shopcardListdata!.data!.length.toString()} itme",
                      style: Style_File.subtitle,
                    ),
                    Text(
                      "\$ ${double.parse(shopcardListdata!.totalPrice.toString()).toStringAsFixed(2)}",
                      style: Style_File.subtitle,
                    ),
                  ],
                ),
                Spacer(),
                ButtonWidget(
                  text: 'View all',
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<CategoriesProvider>(
                          create: (BuildContext context) =>
                              CategoriesProvider(),
                          child: Addtocart(
                            con: con,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
