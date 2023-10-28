import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/category/categoryui.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryScreen extends StatefulWidget {
  final MainController con;
  const CategoryScreen({Key? key, required this.con}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  DashBoradProvider _categoriesProvider = DashBoradProvider();

  bool searchshow = false;
  bool searchbarclose = true;
  TextEditingController sercheditcontroler = new TextEditingController();
  String searchString = '';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _categoriesProvider =
        Provider.of<DashBoradProvider>(context, listen: false);
    _categoriesProvider.categorieslist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        title: Text('Song Type'),
        backgroundColor: colorSecondry,
        // automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<DashBoradProvider>(
        builder: ((context, categories, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: Style_File.edgeInsetsGeometryboth.copyWith(top: 2.h),
                  child: SearchsBar(
                    textEditingController: sercheditcontroler,
                    hinttext: 'search',
                    onChanged: (value) {
                      setState(() {
                        searchString = value;
                      });
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
                SizedBox(
                  height: 1.h,
                ),
                categories.categoriesModel.data != null
                    ? categories.datanotfound
                        ? NoDataFoundErrorScreens(
                            height: 50.h,
                          )
                        : CategoryUIScreen(
                            con: widget.con,
                            categoriesdata: categories.categoriesList,
                            type: "category",
                            searchString: searchString,
                          )
                    : LoaderScreens(),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
