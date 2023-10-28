import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/homesearchprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/home/home.dart';
import 'package:ancientmysticmusic/screen/searchscreen/albumsearch.dart';
import 'package:ancientmysticmusic/screen/searchscreen/artistsearch.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchScreen extends StatefulWidget {
  final MainController con;
  final List<LanguageModelsData> languagelist;
  const SearchScreen({
    super.key,
    required this.con,
    required this.languagelist,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  HomesearchProvider _homesearchProvider = HomesearchProvider();
  bool data = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _homesearchProvider =
        Provider.of<HomesearchProvider>(context, listen: false);
  }

  bool searchshow = false;
  bool searchbarclose = true;
  TextEditingController sercheditcontroler = new TextEditingController();
  String searchString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorSecondry,
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                height: 5.h,
                width: 70.w,
                child: Padding(
                  padding: Style_File.edgeInsetsGeometrysubtitle,
                  child: SearchsBar(
                    textEditingController: sercheditcontroler,
                    hinttext: 'search',
                    onChanged: (value) {
                      setState(() {
                        searchString = value;
                      });
                      _homesearchProvider.albumlist(searchString);
                      if (value.isEmpty) {
                        setState(() {
                          searchbarclose = true;
                          // _itemcheck();
                        });
                      } else {
                        setState(() {
                          searchbarclose = false;
                          // _itemcheck();
                        });
                      }
                    },
                    suffixIcon: true,
                    suffixIconWidget: searchbarclose
                        ? Icon(Icons.search)
                        : InkWell(
                            onTap: () {
                              setState(() {
                                sercheditcontroler.clear();
                                searchString = '';
                                searchbarclose = true;
                              });
                            },
                            child: Icon(Icons.close)),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Style_File.subtitle.copyWith(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 10,
          backgroundColor: colorSecondry,
        ),
        body: Consumer<HomesearchProvider>(
            builder: ((context, homesearchProvider, child) {
          if (homesearchProvider.homesearchalldataartist.isNotEmpty) {
            return

                // data
                //     ?

                //     //  SizedBox(
                //     //     width: 100.w,
                //     //     height: 70.h,
                //     //     child: Center(
                //     //         child: Text(
                //     //       "No Data Found",
                //     //       style: Style_File.title.copyWith(color: Colors.white),
                //     //     )))

                //     NoDataFoundErrorScreens(
                //         height: 50.h,
                //       )
                //     :

                Padding(
              padding: EdgeInsets.only(top: 0.1.h, left: 2.0.h, right: 2.0.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Recent Searches',
                    //         style: Style_File.title.copyWith(
                    //             color: colorWhite, fontSize: 16.sp),
                    //       ),
                    //       Text(
                    //         'See All',
                    //         style: Style_File.title.copyWith(
                    //             color: colorPrimary, fontSize: 16.sp),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),
                    if (homesearchProvider.homesearchalldataalbums.isNotEmpty)
                      Text(
                        'Albums',
                        style: Style_File.title
                            .copyWith(color: colorWhite, fontSize: 16.sp),
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    AlbumSearch(
                      con: widget.con,
                      albumdata: homesearchProvider.homesearchalldataalbums,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    if (homesearchProvider.homesearchalldataartist.isNotEmpty)
                      Text(
                        'Artist',
                        style: Style_File.title
                            .copyWith(color: colorWhite, fontSize: 18.sp),
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ArtistSearch(
                      con: widget.con,
                      artistdata: homesearchProvider.homesearchalldataartist,
                      languagelist: widget.languagelist,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return NoDataFoundErrorScreens(
              height: 50.h,
            );
            //   LoaderScreen();
          }
        })));
  }
}
