import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/library/addtoplay.dart';
import 'package:ancientmysticmusic/screen/library/downloadui.dart';
import 'package:ancientmysticmusic/screen/library/likedartists.dart';
import 'package:ancientmysticmusic/screen/library/likedsong.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LibraryScreen extends StatefulWidget {
  final MainController? con;
  const LibraryScreen({Key? key, this.con}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  DashBoradProvider _dashBoradProvider = DashBoradProvider();

  @override
  void initState() {
    super.initState();
    _dashBoradProvider = Provider.of<DashBoradProvider>(context, listen: false);
    _dashBoradProvider.albumlist('1');
    _dashBoradProvider.artistlist();
    _dashBoradProvider.addPlayListCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorSecondry,
        appBar: AppBar(
          title: Text("Library"),
          elevation: 10,
        ),
        body: Consumer<DashBoradProvider>(
            builder: (context, dashBoradProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // if (dashBoradProvider.albumsList.isNotEmpty)
                //   LikedSong(
                //       con: widget.con, albumdata: dashBoradProvider.albumsList),

                SizedBox(
                  height: 1.h,
                ),

                if (dashBoradProvider.addPlayListList.isNotEmpty)
                  AddPlayListui(
                      con: widget.con,
                      albumdata: dashBoradProvider.addPlayListList),

                SizedBox(
                  height: 1.h,
                ),
                DownloaduiScreen(
                  con: widget.con,
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          );
        }));
  }
}
