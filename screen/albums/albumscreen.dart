import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/albums/albumui.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/screens/addtocard.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AlbumScreen extends StatefulWidget {
  final MainController con;
  AlbumScreen({Key? key, required this.con}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  DashBoradProvider _dashBoradProvider = DashBoradProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashBoradProvider = Provider.of<DashBoradProvider>(context, listen: false);
    fetchdata();
  }

  Future fetchdata() async {
    await _dashBoradProvider.languagelist();

    await _dashBoradProvider
        .albumlist(_dashBoradProvider.indexlamguage.toString());
    await _dashBoradProvider.shopcard();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoradProvider>(
        builder: (context, dashBoradProvider, child) {
      return Scaffold(
          backgroundColor: colorSecondry,
          bottomNavigationBar: dashBoradProvider.shopcardList.isNotEmpty
              ? AddToCardScreens(
                  shopcardListdata: dashBoradProvider.shopcartListModel,
                  con: widget.con,
                )
              : SizedBox(
                  height: 0.h,
                ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: colorWhite),
            title: Text('Albums'),
            backgroundColor: colorSecondry,
            // automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 10,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 8.h,
                  width: 100.w,
                  child: ListView.builder(
                      itemCount: dashBoradProvider.languageList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              dashBoradProvider.indexlamguage =
                                  dashBoradProvider.languageList[index].id!
                                      .toInt();
                              _dashBoradProvider.albumlist(
                                  _dashBoradProvider.indexlamguage.toString());
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: 30.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.w),
                                  color: dashBoradProvider.indexlamguage
                                              .toString() ==
                                          dashBoradProvider
                                              .languageList[index].id
                                              .toString()
                                      ? colorPrimary
                                      : colorWhite),
                              child: Padding(
                                padding: Style_File.edgeInsetsGeometryboth,
                                child: Center(
                                  child: Text(
                                    dashBoradProvider.languageList[index].name!,
                                    style: Style_File.title.copyWith(
                                        color: dashBoradProvider.indexlamguage
                                                    .toString() ==
                                                dashBoradProvider
                                                    .languageList[index].id
                                                    .toString()
                                            ? colorWhite
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                if (dashBoradProvider.fetchdatalanguage)
                  if (dashBoradProvider.albumsList.isNotEmpty)
                    AlbumUI(
                      con: widget.con,
                      albumdata: dashBoradProvider.albumsList,
                      oncallback: (value) {
                        if (value == StringFile.select) {
                          dashBoradProvider.shopcard();
                        }
                      },
                    ),
                if (!dashBoradProvider.fetchdatalanguage)
                  SizedBox(
                    height: 50.h,
                    child: Center(
                      child: LoaderScreens(),
                    ),
                  ),
                if (dashBoradProvider.fetchdatalanguage)
                  if ((dashBoradProvider.albumsList.isEmpty))
                    NoDataFoundErrorScreens(
                      height: 50.h,
                    )
              ],
            ),
          ));
    });
  }
}
