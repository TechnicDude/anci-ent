import 'package:ancientmysticmusic/apis/paymentapi.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/albums/imagealbumui.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/screens/confirmcart.dart';
import 'package:ancientmysticmusic/utils/screens/payment/couponsshowui.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Addtocart extends StatefulWidget {
  final MainController con;
  const Addtocart({super.key, required this.con});

  @override
  State<Addtocart> createState() => _AddtocartState();
}

class CartList {
  CartList(
    this.image,
    this.title,
    this.crossprice,
    this.price,
    this.subtitle,
    this.select,
    this.addcart,
    this.icon,
  );

  final String image;
  final String title;
  final String crossprice;
  final String price;
  final String subtitle;
  final String select;
  final String addcart;
  final String icon;
}

class _AddtocartState extends State<Addtocart> {
  CategoriesProvider _categoriesProvider = CategoriesProvider();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    _categoriesProvider.shopcard('0');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
        builder: (context, shopProvider, child) {
      return Scaffold(
        bottomNavigationBar: shopProvider.shopcartListModel != null
            ? Container(
                height: 17.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    ConfirmCart(
                        oncallback: (value) {
                          if (value == "ok") {
                            _categoriesProvider.shopcard('0');
                          }
                        },
                        totalprice: shopProvider.shopcartListModel.totalPrice
                                    .toString() !=
                                "null"
                            ? shopProvider.shopcartListModel.totalPrice
                                .toString()
                            : ''),
                  ],
                ),
              )
            : Container(),
        backgroundColor: colorSecondry,
        appBar: AppBar(
          title: Text('My Cart'),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.shopping_bag_outlined),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: Padding(
          padding: Style_File.cardpadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                ClayContainer(
                  color: colorSecondry,
                  borderRadius: 2.w,
                  curveType: CurveType.concave,
                  spread: 1,
                  depth: 25,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 1.h, bottom: 1.h, left: 1.w, right: 1.w),
                    child: Row(children: [
                      Text(
                        "Use coupons",
                        style: Style_File.title,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<CategoriesProvider>(
                                create: (BuildContext context) =>
                                    CategoriesProvider(),
                                child: CouponsShowScreen(
                                  callback: (value) {
                                    shopProvider.shopcard(value.toString());
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "View all",
                          style:
                              Style_File.subtitle.copyWith(color: Colors.red),
                        ),
                      ),
                    ]),
                  ),
                ),
                ListView.builder(
                  itemCount: shopProvider.shopcardList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
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
                                  // IMmageCallAlbumScreen(
                                  //     imageurl: cartlist[index].image),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  IMmageCallAlbumScreen(
                                      imageurl: shopProvider
                                                  .shopcardList[index].songId
                                                  .toString()
                                                  .toString() !=
                                              "null"
                                          ? shopProvider
                                              .shopcardList[index].songs!.image!
                                          : shopProvider.shopcardList[index]
                                              .albums!.image!),

                                  SizedBox(
                                    width: 3.w,
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shopProvider.shopcardList[index].songId
                                                    .toString()
                                                    .toLowerCase() !=
                                                "null"
                                            ? shopProvider.shopcardList[index]
                                                .songs!.title!
                                            : shopProvider.shopcardList[index]
                                                .albums!.title!,
                                        style: Style_File.title,
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                          "\$ ${shopProvider.shopcardList[index].songId.toString().toLowerCase() != "null" ? shopProvider.shopcardList[index].songs!.price! : shopProvider.shopcardList[index].albums!.price!}",
                                          style: Style_File.subtitle
                                              .copyWith(color: colorPrimary)),
                                    ],
                                  ),

                                  Spacer(),
                                  SizedBox(
                                    height: 20.w,
                                    child: InkWell(
                                        // iconSize: .5.w,
                                        onTap: () async {
                                          // Navigator.pop(context);
                                          var body = {
                                            "user_id": MyApp.userid,
                                            "album_id": shopProvider
                                                        .shopcardList[index]
                                                        .songId
                                                        .toString()
                                                        .toLowerCase() !=
                                                    "null"
                                                ? ""
                                                : shopProvider
                                                    .shopcardList[index].albumId
                                                    .toString(),
                                            "song_id": shopProvider
                                                        .shopcardList[index]
                                                        .songId
                                                        .toString()
                                                        .toLowerCase() !=
                                                    "null"
                                                ? shopProvider
                                                    .shopcardList[index].songId
                                                    .toString()
                                                : "",
                                          };
                                          PaymentApi paymentApi =
                                              PaymentApi(body);
                                          final response =
                                              await paymentApi.removeToCart();
                                          if (response['status'] == 'true') {
                                            _categoriesProvider.shopcard('0');
                                          }
                                        },
                                        child: Icon(
                                          size: 7.w,
                                          Icons.delete_outline_outlined,
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
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
