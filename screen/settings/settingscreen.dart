import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/provider/PaymenthistoryProvider.dart';
import 'package:ancientmysticmusic/provider/aboutprovider.dart';
import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/privacyprovider.dart';
import 'package:ancientmysticmusic/provider/profileuserprovider.dart';
import 'package:ancientmysticmusic/provider/termsprovider.dart';
import 'package:ancientmysticmusic/screen/auth/loginallTab.dart';

import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/notification/notification.dart';
import 'package:ancientmysticmusic/screen/profile/editprofile.dart';
import 'package:ancientmysticmusic/screen/settings/PaymentHistory.dart';
import 'package:ancientmysticmusic/screen/settings/aboutscreen.dart';
import 'package:ancientmysticmusic/screen/settings/privacypolicy.dart';
import 'package:ancientmysticmusic/screen/settings/termscondition.dart';
import 'package:ancientmysticmusic/screen/settings/transactionhistory.dart';
import 'package:ancientmysticmusic/screen/splashscreen.dart';
import 'package:ancientmysticmusic/utils/button_widget.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/screens/confirmcart.dart';
import 'package:ancientmysticmusic/utils/screens/payment/addcartdesign.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SettingScreen extends StatefulWidget {
  final MainController con;
  const SettingScreen({Key? key, required this.con}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ProfileUserProvider _profileuserProvider = ProfileUserProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _profileuserProvider =
        Provider.of<ProfileUserProvider>(context, listen: false);
    _profileuserProvider.profileuserlist(MyApp.userid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorSecondry,
        appBar: AppBar(
          title: Text("Settings"),
          elevation: 10,
        ),
        body: Consumer<ProfileUserProvider>(
            builder: ((context, profileUserProvider, child) {
          return Padding(
            padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 2.0.h),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 4.h,
                      backgroundImage: profileUserProvider
                              .profileuserList.isNotEmpty
                          ? profileUserProvider.profileuserList[0].image != ''
                              ? NetworkImage(APIURL.imageurl +
                                  profileUserProvider.profileuserList[0].image
                                      .toString())
                              : AssetImage(ImageFile.profile) as ImageProvider
                          : AssetImage(ImageFile.profile),
                    ),
                  ),
                  SizedBox(
                    width: 2.h,
                  ),
                  Center(
                      child: Text(
                          profileUserProvider.profileuserList.isNotEmpty
                              ? profileUserProvider
                                      .profileuserList[0].firstName ??
                                  ''
                              : '',
                          style: Style_File.title.copyWith(color: colorWhite))),
                  Spacer(),
                  profileUserProvider.profileuserList.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<
                                            ProfileUserProvider>(
                                          create: (BuildContext context) =>
                                              ProfileUserProvider(),
                                          child: EditProfileScreen(
                                              profileuserdata:
                                                  profileUserProvider
                                                      .profileuserList),
                                        ))).then((value) {
                              _profileuserProvider
                                  .profileuserlist(MyApp.userid ?? '');
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 24,
                            color: colorPrimary,
                          ))
                      : Container(),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Divider(
                color: colorGrey,
                thickness: 0.07.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Text(
                    "My Cart",
                    style: Style_File.title.copyWith(color: colorWhite),
                  )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                ChangeNotifierProvider<CategoriesProvider>(
                              create: (BuildContext context) =>
                                  CategoriesProvider(),
                              child: Addtocart(
                                con: widget.con,
                              ),
                            ),
                          ),
                        );

                        //  ConfirmCart()));
                        //  Navigator.pushNamed(context, Routes.paymentHistory);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: colorWhite,
                      )),
                ],
              ),
              Divider(
                color: colorGrey,
                thickness: 0.07.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Text(
                    "Transaction History",
                    style: Style_File.title.copyWith(color: colorWhite),
                  )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ChangeNotifierProvider<
                                        PaymenthistoryProvider>(
                                      create: (BuildContext context) =>
                                          PaymenthistoryProvider(),
                                      child: TransactionHistory(
                                          //  con: con,
                                          // albumdata: albumdata![index],
                                          ),
                                    )));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: colorWhite,
                      )),
                ],
              ),

              Divider(
                color: colorGrey,
                thickness: 0.07.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Text(
                    "About Us",
                    style: Style_File.title.copyWith(color: colorWhite),
                  )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider<AboutProvider>(
                                      create: (BuildContext context) =>
                                          AboutProvider(),
                                      child: AboutScreen(
                                          //  con: con,
                                          // albumdata: albumdata![index],
                                          ),
                                    )));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: colorWhite,
                      )),
                ],
              ),
              Divider(
                color: colorGrey,
                thickness: 0.07.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Text(
                    "Terms & Conditions",
                    style: Style_File.title.copyWith(color: colorWhite),
                  )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider<TermsProvider>(
                                      create: (BuildContext context) =>
                                          TermsProvider(),
                                      child: TermsCondition(
                                          //  con: con,
                                          // albumdata: albumdata![index],
                                          ),
                                    )));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: colorWhite,
                      )),
                ],
              ),
              Divider(
                color: colorGrey,
                thickness: 0.07.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Text(
                    "Privacy Policy",
                    style: Style_File.title.copyWith(color: colorWhite),
                  )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider<PrivacyProvider>(
                                      create: (BuildContext context) =>
                                          PrivacyProvider(),
                                      child: PrivacyPolicy(
                                          //  con: con,
                                          // albumdata: albumdata![index],
                                          ),
                                    )));

                        //  Navigator.pushNamed(context, Routes.privacyPolicy);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: colorWhite,
                      )),
                ],
              ),

              Divider(
                color: colorGrey,
                thickness: 0.07.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Text(
                    "Logout",
                    style: Style_File.title.copyWith(color: colorWhite),
                  )),
                  IconButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO,
                          btnOkColor: colorSecondry,
                          borderSide:
                              BorderSide(color: colorSecondry, width: 2),
                          buttonsBorderRadius:
                              BorderRadius.all(Radius.circular(2)),
                          headerAnimationLoop: false,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Logout',
                          desc:
                              'Are you sure you want to logout of Ancient Mystic Music?',
                          showCloseIcon: true,
                          // btnCancelOnPress: () {
                          //   Navigator.pop(context);
                          // },
                          btnOkOnPress: () {
                            if (MyApp.userid == null) {
                              // Navigator.pushNamed(context, Routes.loginallTab);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => LoginallTab()));
                            } else {
                              MyApp.logout();
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     CupertinoPageRoute(builder: (context) => LoginallTab()),
                              //     (Route<dynamic> route) => false);
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamedAndRemoveUntil(Routes.loginallTab,
                                      (Route<dynamic> route) => false);
                              // Navigator.of(context).pushNamedAndRemoveUntil(
                              //     Routes.loginallTab, (Route<dynamic> route) => false);
                            }
                          },
                        )..show();
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: colorWhite,
                      )),
                ],
              ),

              Divider(
                color: colorGrey,
                thickness: 0.07.h,
              ),

// payment history screen

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Center(
              //         child: Text(
              //       "Payment History",
              //       style: Style_File.title.copyWith(color: colorWhite),
              //     )),
              //     IconButton(
              //         onPressed: () {
              //           Navigator.push(
              //               context,
              //               CupertinoPageRoute(
              //                   builder: (context) =>
              //                       // ChangeNotifierProvider<PrivacyProvider>(
              //                       //   create: (BuildContext context) =>
              //                       //       PrivacyProvider(),
              //                       //   child: PrivacyPolicy(
              //                       //       //  con: con,
              //                       //       // albumdata: albumdata![index],
              //                       //       ),
              //                       // )
              //                       PaymentHistory()));

              //           //  Navigator.pushNamed(context, Routes.paymentHistory);
              //         },
              //         icon: Icon(
              //           Icons.arrow_forward_ios,
              //           size: 18,
              //           color: colorWhite,
              //         )),
              //   ],
              // ),

// logout button

              // SizedBox(
              //   height: 3.h,
              // ),
              // Center(
              //   child: ButtonWidget(
              //     text: 'Logout',
              //     onTap: () {
              //       AwesomeDialog(
              //         context: context,
              //         dialogType: DialogType.INFO,
              //         btnOkColor: colorSecondry,
              //         borderSide: BorderSide(color: colorSecondry, width: 2),
              //         buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
              //         headerAnimationLoop: false,
              //         animType: AnimType.BOTTOMSLIDE,
              //         title: 'Logout',
              //         desc:
              //             'Are you sure you want to logout of Ancient Mystic Music?',
              //         showCloseIcon: true,
              //         // btnCancelOnPress: () {
              //         //   Navigator.pop(context);
              //         // },
              //         btnOkOnPress: () {
              //           if (MyApp.userid == null) {
              //             // Navigator.pushNamed(context, Routes.loginallTab);
              //             Navigator.push(
              //                 context,
              //                 CupertinoPageRoute(
              //                     builder: (context) => LoginallTab()));
              //           } else {
              //             MyApp.logout();
              //             // Navigator.pushAndRemoveUntil(
              //             //     context,
              //             //     CupertinoPageRoute(builder: (context) => LoginallTab()),
              //             //     (Route<dynamic> route) => false);
              //             Navigator.of(context, rootNavigator: true)
              //                 .pushNamedAndRemoveUntil(Routes.loginallTab,
              //                     (Route<dynamic> route) => false);
              //             // Navigator.of(context).pushNamedAndRemoveUntil(
              //             //     Routes.loginallTab, (Route<dynamic> route) => false);
              //           }
              //         },
              //       )..show();

              //       // showDialog(
              //       //   context: context,
              //       //   builder: (ctx) => AlertDialog(
              //       //     title: Row(
              //       //       children: [
              //       //         Center(child: Center(child: Text("Logout"))),
              //       //         Spacer(),
              //       //         IconButton(
              //       //             onPressed: () {
              //       //               Navigator.pop(context);
              //       //             },
              //       //             icon: Icon(
              //       //               Icons.close,
              //       //               color: colorGrey,
              //       //               // size: 18,
              //       //             )),
              //       //       ],
              //       //     ),
              //       //     content: Text(
              //       //         "Are you sure you want to logout of Ancient Mystic Music?",
              //       //         style:
              //       //             Style_File.subtitle.copyWith(color: colorGrey)),
              //       //     actions: <Widget>[
              //       //       TextButton(
              //       //         onPressed: () {
              //       //           if (MyApp.userid == null) {
              //       //             Navigator.pushNamed(
              //       //                 context, Routes.loginallTab);
              //       //           } else {
              //       //             MyApp.logout();
              //       //             Navigator.of(context).pushNamedAndRemoveUntil(
              //       //                 Routes.loginallTab,
              //       //                 (Route<dynamic> route) => false);
              //       //           }
              //       //           // Navigator.of(ctx).pop();
              //       //         },
              //       //         child: Center(
              //       //           child: Container(
              //       //             height: 3.5.h,
              //       //             width: 20.h,
              //       //             color: colorSecondry,
              //       //             // padding: EdgeInsets.all(14),
              //       //             child: Center(
              //       //                 child: Text(
              //       //               "Yes",
              //       //               style: Style_File.title
              //       //                   .copyWith(color: colorWhite),
              //       //             )),
              //       //           ),
              //       //         ),
              //       //       ),
              //       //     ],
              //       //   ),
              //       // );
              //     },
              //   ),
              // ),
            ])),
          );
        })));
  }
}
