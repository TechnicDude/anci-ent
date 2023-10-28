import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/profileuserprovider.dart';
import 'package:ancientmysticmusic/screen/albums/albumscreen.dart';
import 'package:ancientmysticmusic/screen/artists/artistscreen.dart';
import 'package:ancientmysticmusic/screen/auth/login.dart';
import 'package:ancientmysticmusic/screen/auth/loginallTab.dart';
import 'package:ancientmysticmusic/screen/category/category.dart';
import 'package:ancientmysticmusic/screen/downloads/downloads.dart';
import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/library/libraryscreen.dart';
import 'package:ancientmysticmusic/screen/profile/profile.dart';
import 'package:ancientmysticmusic/screen/settings/settingscreen.dart';
import 'package:ancientmysticmusic/screen/single/singlelistui.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/screens/payment/addcartdesign.dart';
import 'package:ancientmysticmusic/utils/stack_bar.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../page_routes/routes.dart';
import 'colors.dart';

class MenuBarScreens extends StatelessWidget {
  final MainController con;
  final List<LanguageModelsData> languagelist;

  const MenuBarScreens({
    Key? key,
    required this.con,
    required this.languagelist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colorPrimary,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ListView(
          padding: EdgeInsets.only(left: 1.h, right: 1.h),
          children: [
            Container(
              height: 18.h,
              child: DrawerHeader(
                child: Image.asset(ImageFile.logo),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('HOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    CupertinoPageRoute(builder: (context) => BottomNav()),
                    (Route<dynamic> route) => false);

                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     Routes.bottomNav, (Route<dynamic> route) => false);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.queue_music_outlined,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('SONG TYPES',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<DashBoradProvider>(
                              create: (BuildContext context) =>
                                  DashBoradProvider(),
                              child: CategoryScreen(
                                con: con,
                                // albumdata: albumdata![index],
                              ),
                            )));

                // _categoriesProvider =
                //     Provider.of<DashBoradProvider>(context, listen: false);
                // _categoriesProvider.categorieslist();

// Navigator.pushNamed(context, Routes.categoryScreen, arguments: {
//                   StringFile.profileuserdata:
//                       DashBoradProvider.categoriesList,
//                 }).then((value) {
//                   _categoriesProvider.categorieslist(MyApp.userid ?? '');
//                 });

                // Navigator.pushNamed(context, Routes.categoryScreen);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_album_outlined,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('SINGLES',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<DashBoradProvider>(
                              create: (BuildContext context) =>
                                  DashBoradProvider(),
                              child: SingleListUIScreenActivity(
                                con: con,
                                // albumdata: albumdata![index],
                              ),
                            )));

                //Navigator.pushNamed(context, Routes.albumScreen);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_album_outlined,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('ALBUMS',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<DashBoradProvider>(
                              create: (BuildContext context) =>
                                  DashBoradProvider(),
                              child: AlbumScreen(
                                con: con,
                                // albumdata: albumdata![index],
                              ),
                            )));

                //Navigator.pushNamed(context, Routes.albumScreen);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            // ListTile(
            //   leading: const Icon(
            //     Icons.library_music_sharp,
            //     size: 18,
            //     color: Colors.white,
            //   ),
            //   title: const Text('RECENT PLAYED',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: 'Amazon',
            //       )),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, Routes.recentPlayed);
            //   },
            // ),

            ListTile(
              leading: const Icon(
                Icons.library_music_sharp,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('ARTISTS',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<DashBoradProvider>(
                              create: (BuildContext context) =>
                                  DashBoradProvider(),
                              child: ArtistScreen(
                                con: con,
                                languagelist: languagelist,
                                // albumdata: albumdata![index],
                              ),
                            )));

                //Navigator.pushNamed(context, Routes.artistScreen);
              },
            ),

            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            // ListTile(
            //   leading: const Icon(
            //     Icons.library_music_sharp,
            //     size: 18,
            //     color: Colors.white,
            //   ),
            //   title: const Text('RECENT PLAYED',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: 'Amazon',
            //       )),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, Routes.recentPlayed);
            //   },
            // ),

            ListTile(
              leading: const Icon(
                Icons.shopping_cart,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('MY CART',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<CategoriesProvider>(
                      create: (BuildContext context) => CategoriesProvider(),
                      child: Addtocart(
                        con: con,
                      ),
                    ),
                  ),
                );
              },
            ),

            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.install_mobile,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('DOWNLOADS',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          // ChangeNotifierProvider<DashBoradProvider>(
                          //   create: (BuildContext context) =>
                          //       DashBoradProvider(),
                          //child:
                          DownloadScreen(
                        con: con,
                        // albumdata: albumdata![index],
                      ),
                    ));

                // Navigator.pushNamed(context, Routes.downloadScreen);
              },
            ),

            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('SETTING',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<ProfileUserProvider>(
                              create: (BuildContext context) =>
                                  ProfileUserProvider(),
                              child: SettingScreen(
                                con: con,
                                // albumdata: albumdata![index],
                              ),
                            )));
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.login,
                size: 18,
                color: Colors.white,
              ),
              title: Text(MyApp.userid == null ? 'LOGIN' : 'LOGOUT',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                // AwesomeDialog(
                //   context: context,
                //   dialogType: DialogType.INFO,
                //   btnOkColor: colorSecondry,
                //   borderSide: BorderSide(color: colorSecondry, width: 2),
                //   buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                //   headerAnimationLoop: false,
                //   animType: AnimType.BOTTOMSLIDE,
                //   title: 'Logout',
                //   desc:
                //       'Are you sure you want to logout of Ancient Mystic Music?',
                //   showCloseIcon: true,
                //   // btnCancelOnPress: () {
                //   //   Navigator.pop(context);
                //   // },
                //   btnOkOnPress: () {
                //     if (MyApp.userid == null) {
                //       Navigator.push(
                //           context,
                //           CupertinoPageRoute(
                //               builder: (context) => LoginallTab()));
                //     } else {
                //       MyApp.logout();

                //       Navigator.of(context, rootNavigator: true)
                //           .pushNamedAndRemoveUntil(Routes.loginallTab,
                //               (Route<dynamic> route) => false);
                //     }
                //   },
                // )..show();

                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  btnOkColor: colorSecondry,
                  borderSide: BorderSide(color: colorSecondry, width: 2),
                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
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
                      Navigator.pushNamed(context, Routes.loginallTab);
                      // if (MyApp.userid == null) {
                      //   Navigator.of(context, rootNavigator: true)
                      //       .pushNamedAndRemoveUntil(Routes.loginallTab);
                      //  (Route<dynamic> route) => false);
                    } else {
                      MyApp.logout();

                      Navigator.of(context, rootNavigator: true)
                          .pushNamedAndRemoveUntil(Routes.loginallTab,
                              (Route<dynamic> route) => false);
                    }
                  },
                )..show();

                // if (MyApp.userid == null) {
                //   // Navigator.pushNamed(context, Routes.loginallTab);
                //   Navigator.push(context,
                //       CupertinoPageRoute(builder: (context) => LoginallTab()));
                // } else {
                //   MyApp.logout();
                //   // Navigator.pushAndRemoveUntil(
                //   //     context,
                //   //     CupertinoPageRoute(builder: (context) => LoginallTab()),
                //   //     (Route<dynamic> route) => false);
                //   Navigator.of(context, rootNavigator: true)
                //       .pushNamedAndRemoveUntil(
                //           Routes.loginallTab, (Route<dynamic> route) => false);
                //   // Navigator.of(context).pushNamedAndRemoveUntil(
                //   //     Routes.loginallTab, (Route<dynamic> route) => false);
                // }
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            SizedBox(
              height: 8.h,
            )
            // ListTile(
            //   leading: const Icon(
            //     Icons.logout_sharp,
            //     size: 18,
            //     color: Colors.white,
            //   ),
            //   title: const Text('LOGOUT',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: 'Amazon',
            //       )),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, Routes.LocDb);
            //   },

            //   // title: const Text('LOGIN',
            //   //     style: TextStyle(
            //   //       color: Colors.white,
            //   //       fontFamily: 'Amazon',
            //   //     )),
            //   // onTap: () {
            //   //   Navigator.pushReplacementNamed(context, Routes.loginallTab);
            //   // },
            // ),
          ],
        ),
      ),
    );
  }
}
