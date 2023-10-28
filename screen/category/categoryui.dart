import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/model/categoriesmodel.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/category/categorysong.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/imagecard.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryUIScreen extends StatefulWidget {
  final MainController con;

  List<CategoriesData> categoriesdata;
  final String type;
  final String searchString;

  CategoryUIScreen(
      {Key? key,
      required this.categoriesdata,
      required this.type,
      required this.con,
      required this.searchString})
      : super(key: key);

  @override
  State<CategoryUIScreen> createState() => _CategoryUIScreenState();
}

class _CategoryUIScreenState extends State<CategoryUIScreen> {
// search bar here

  List<CategoriesData> allcategoriesdata = [];

  Future _itemcheck() async {
    allcategoriesdata = [];
    for (int i = 0; i < widget.categoriesdata.length; i++) {
      if (widget.categoriesdata[i].categoryname!
          .toLowerCase()
          .contains(widget.searchString.toLowerCase())) {
        allcategoriesdata.add(widget.categoriesdata[i]);
      }
    }
    return allcategoriesdata;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _itemcheck(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (allcategoriesdata.isEmpty) {
              return NoDataFoundErrorScreens(
                height: 50.h,
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.only(
                    left: 2.w, right: 2.w, top: 2.w, bottom: 2.w),
                itemCount: allcategoriesdata.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / .2.h),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<CategoriesProvider>(
                                    create: (BuildContext context) =>
                                        CategoriesProvider(),
                                    child: CategorySong(
                                      con: widget.con,
                                      id: allcategoriesdata[index]
                                          .id
                                          .toString(),
                                      title:
                                          allcategoriesdata[index].categoryname,
                                    ),
                                  )));
                    },
                    child: ClayContainer(
                      color: colorSecondry,
                      borderRadius: 4.w,
                      curveType: CurveType.concave,
                      spread: 1,
                      depth: 25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CachedNetworkImage(
                            imageUrl: APIURL.imageurl +
                                allcategoriesdata[index].image!,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 30.w,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.w),
                                  topRight: Radius.circular(4.w),
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              height: 30.w,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.w),
                                  topRight: Radius.circular(4.w),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            width: 80.w,
                            child: Text(
                                allcategoriesdata[index].categoryname ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Style_File.subtitle
                                    .copyWith(color: colorWhite)),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return LoaderScreens();
          }
        });
  }
}
