// ignore_for_file: use_build_context_synchronously

import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/homesearchprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/profileuserprovider.dart';
import 'package:ancientmysticmusic/screen/albums/albumscreen.dart';
import 'package:ancientmysticmusic/screen/artists/artistscreen.dart';
import 'package:ancientmysticmusic/screen/category/categorysong.dart';
import 'package:ancientmysticmusic/screen/home/TabHome.dart';
import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/home/homealbums.dart';
import 'package:ancientmysticmusic/screen/home/homeartist.dart';
import 'package:ancientmysticmusic/screen/home/homerecentlyplay.dart';
import 'package:ancientmysticmusic/screen/home/homesiglesongui.dart';
import 'package:ancientmysticmusic/screen/home/recentplaylist.dart';
import 'package:ancientmysticmusic/screen/home/slider.dart';
import 'package:ancientmysticmusic/screen/notification/notification.dart';
import 'package:ancientmysticmusic/screen/recentlyplayed/recentplayed.dart';
import 'package:ancientmysticmusic/screen/searchscreen/searchscreen.dart';
import 'package:ancientmysticmusic/screen/settings/settingscreen.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/homebuttontwo.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../main.dart';
import '../../utils/menubar.dart';

class HomeScreen extends StatefulWidget {
  final MainController con;
  const HomeScreen({Key? key, required this.con}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DashBoradProvider _dashBoradProvider = DashBoradProvider();

  // bool searchshow = false;
  // TextEditingController sercheditcontroler = new TextEditingController();
  // String searchString = '';

  @override
  void initState() {
    _dashBoradProvider = Provider.of<DashBoradProvider>(context, listen: false);
    getalldata();
    print("userid ${MyApp.userid}");

    super.initState();
  }

  getalldata() async {
    await _dashBoradProvider.languagelist();
    await _dashBoradProvider.bannerlist();

    await _dashBoradProvider.categorieslist();
    await _dashBoradProvider.listPlayedSong();
    await _dashBoradProvider.albumlist('1');

    await _dashBoradProvider.singleSonglist('1');
    await _dashBoradProvider.artistlist();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _dashBoradProvider.bannerlist();
  //   _dashBoradProvider.categorieslist();
  //   _dashBoradProvider.albumlist();
  //   _dashBoradProvider.artistlist();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoradProvider>(
        builder: (context, dashBoradProvider, child) {
      return Scaffold(
          backgroundColor: colorSecondry,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset(ImageFile.navbar),
                  color: colorPrimary,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            automaticallyImplyLeading: false,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<HomesearchProvider>(
                                    create: (BuildContext context) =>
                                        HomesearchProvider(),
                                    child: SearchScreen(
                                      con: widget.con,
                                      languagelist:
                                          dashBoradProvider.languageList,
                                      // albumdata: albumdata![index],
                                    ),
                                  )));
                    },
                    icon: const Icon(Icons.search),
                    color: colorPrimary,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<DashBoradProvider>(
                                    create: (BuildContext context) =>
                                        DashBoradProvider(),
                                    child: RecentPlayed(
                                      con: widget.con,
                                    ),
                                  )));
                    },
                    icon: const Icon(Icons.video_collection_outlined),
                    color: colorPrimary,
                  ),
                ],
              ),
            ],
            centerTitle: true,
            elevation: 10,
            backgroundColor: colorSecondry,
          ),

          // navigation drawer

          drawer: MenuBarScreens(
            con: widget.con,
            languagelist: dashBoradProvider.languageList,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (dashBoradProvider.bannerList.isNotEmpty)
                  SliderScreen(bannerdata: dashBoradProvider.bannerList),
                SizedBox(
                  height: 2.h,
                ),
                if (dashBoradProvider.categoriesList.isNotEmpty)
                  Padding(
                    padding: Style_File.edgeInsetsGeometry,
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,

                        spacing: 10,
                        runSpacing: 5,
                        // direction: Axis.vertical,
                        children: [
                          for (int i = 0;
                              i <
                                  (dashBoradProvider.categoriesList.length > 6
                                      ? 6
                                      : dashBoradProvider
                                          .categoriesList.length);
                              i++)
                            ButtonHome2(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider<
                                                CategoriesProvider>(
                                              create: (BuildContext context) =>
                                                  CategoriesProvider(),
                                              child: CategorySong(
                                                con: widget.con,
                                                id: dashBoradProvider
                                                    .categoriesList[i].id
                                                    .toString(),
                                                title: dashBoradProvider
                                                    .categoriesList[i]
                                                    .categoryname,
                                              ),
                                            )));
                              }),
                              text: dashBoradProvider
                                  .categoriesList[i].categoryname,
                            )
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 2.h,
                ),
                if (dashBoradProvider.songartistList.isNotEmpty)
                  Padding(
                    padding: Style_File.edgeInsetsGeometryboth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringFile.recentlyPlayed,
                          style: Style_File.title,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 1.h,
                ),
                //recent played

                if (dashBoradProvider.songartistList.isNotEmpty)
                  SizedBox(
                    height: 20.h,
                    child: HomeSongAlbumsScreens(
                        con: widget.con,
                        albumdata: dashBoradProvider.songartistList),
                  ),
                SizedBox(
                  height: 2.h,
                ),
                if (dashBoradProvider.siglesonglistlist.isNotEmpty)
                  Padding(
                    padding: Style_File.edgeInsetsGeometryboth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringFile.singlePlayed,
                          style: Style_File.title,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 1.h,
                ),
                //single song play

                if (dashBoradProvider.siglesonglistlist.isNotEmpty)
                  SizedBox(
                    height: 20.h,
                    child: HomeSongSinglesScreens(
                        con: widget.con,
                        albumdata: dashBoradProvider.siglesonglistlist),
                  ),
                SizedBox(
                  height: 2.h,
                ),
                if (dashBoradProvider.albumsList.isNotEmpty)
                  Padding(
                    padding: Style_File.edgeInsetsGeometryboth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringFile.albums,
                          style: Style_File.title,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<
                                            DashBoradProvider>(
                                          create: (BuildContext context) =>
                                              DashBoradProvider(),
                                          child: AlbumScreen(
                                            con: widget.con,
                                            // albumdata: albumdata![index],
                                          ),
                                        )));
                          },
                          child: Text(StringFile.viewall,
                              style: Style_File.subtitle
                                  .copyWith(color: colorPrimary)),
                        ),
                      ],
                    ),
                  ),

                SizedBox(
                  height: 1.h,
                ),
                // album screen
                if (dashBoradProvider.albumsList.isNotEmpty)
                  SizedBox(
                    height: 20.h,
                    child: HomeAlbumsScreens(
                        con: widget.con,
                        albumdata: dashBoradProvider.albumsList),
                  ),
                SizedBox(
                  height: 2.h,
                ),
                if (dashBoradProvider.artistList.isNotEmpty)
                  Padding(
                    padding: Style_File.edgeInsetsGeometryboth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringFile.artist,
                          style: Style_File.title,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<
                                            DashBoradProvider>(
                                          create: (BuildContext context) =>
                                              DashBoradProvider(),
                                          child: ArtistScreen(
                                            con: widget.con,
                                            languagelist:
                                                dashBoradProvider.languageList,
                                            // albumdata: albumdata![index],
                                          ),
                                        )));
                          },
                          child: Text(StringFile.viewall,
                              style: Style_File.subtitle
                                  .copyWith(color: colorPrimary)),
                        ),
                      ],
                    ),
                  ),

                SizedBox(
                  height: 1.h,
                ),
                if (dashBoradProvider.artistList.isNotEmpty)
                  SizedBox(
                    height: 15.h,
                    child: HomeArtistsScreens(
                      con: widget.con,
                      artistdata: dashBoradProvider.artistList,
                      languagelist: dashBoradProvider.languageList,
                    ),
                  ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ));
    });
  }
}
