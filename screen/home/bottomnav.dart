// ignore_for_file: prefer_const_constructors

import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/albums/albumscreen.dart';
import 'package:ancientmysticmusic/screen/category/category.dart';
import 'package:ancientmysticmusic/screen/current_playing/current_playing_song.dart';
import 'package:ancientmysticmusic/screen/home/home.dart';
import 'package:ancientmysticmusic/screen/library/libraryscreen.dart';
import 'package:ancientmysticmusic/screen/profile/profile.dart';
import 'package:ancientmysticmusic/utils/bottom_bar/bottom_nav_bar/models/nav-bar-padding.model.dart';
import 'package:ancientmysticmusic/utils/bottom_bar/bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:ancientmysticmusic/utils/bottom_bar/bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:ancientmysticmusic/utils/bottom_bar/bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:ancientmysticmusic/utils/bottom_bar/bottom_nav_bar/persistent-tab-view.widget.dart';
import 'package:ancientmysticmusic/utils/bottom_bar/bottomuse/curved_navigation_bar.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/screens/bottom_play_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/profileuserprovider.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  @override
  void initState() {
    super.initState();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(CupertinoIcons.home),
          activeColorSecondary: Colors.white,
          activeColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.queue_music_outlined),
          inactiveIcon: const Icon(CupertinoIcons.music_note_list),
          activeColorSecondary: Colors.white,
          activeColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.library_music_sharp),
          inactiveIcon: const Icon(CupertinoIcons.music_albums_fill),
          activeColorSecondary: Colors.white,
          activeColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite_rounded),
          inactiveIcon: const Icon(CupertinoIcons.heart_circle_fill),
          activeColorSecondary: Colors.white,
          activeColorPrimary: Colors.grey),
    ];
  }

  List<Widget> _buildScreens(con) {
    return [
      HomeScreen(
        con: con,
      ),
      CategoryScreen(
        con: con,
      ),
      AlbumScreen(
        con: con,
      ),
      LibraryScreen(
        con: con,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: MainController()..init(),
        // create: (context) => ,
        child: Consumer<MainController>(builder: (context, con, child) {
          return SafeArea(
            child: PersistentTabView(
              stateManagement: false,
              context,
              controller: controller,
              // playWidget: Container(),
              playWidget: Material(
                color: colorSecondry,
                child: PlayWidget(
                    con: con,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: false,
                        builder: (context) => CurrentPlayingSong(
                          con: con,
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(
                      //       builder: (context) => CurrentPlayer(
                      //         con: con,
                      //       ),
                    }),
              ),
              screens: _buildScreens(con),
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor: colorSecondry,
              handleAndroidBackButtonPress: true,
              hideNavigationBarWhenKeyboardShows: true,
              resizeToAvoidBottomInset: true,
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              navBarStyle: NavBarStyle.neumorphic,
              navBarHeight: 55,
              padding: const NavBarPadding.all(0),
            ),
          );
        }));
  }
}
