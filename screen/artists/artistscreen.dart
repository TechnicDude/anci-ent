import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/artists/artistui.dart';
import 'package:ancientmysticmusic/screen/artists/popularartistui.dart';
import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/screens/addtocard.dart';
import 'package:ancientmysticmusic/utils/searchbar.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ArtistScreen extends StatefulWidget {
  final MainController con;

  final List<LanguageModelsData> languagelist;
  const ArtistScreen({
    super.key,
    required this.con,
    required this.languagelist,
  });

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  DashBoradProvider _dashBoradProvider = DashBoradProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashBoradProvider = Provider.of<DashBoradProvider>(context, listen: false);

    _dashBoradProvider.artistlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      // bottomNavigationBar: AddToCardScreens(),
      appBar: AppBar(
        title: Text('Artist'),
        elevation: 10,
      ),
      body: Consumer<DashBoradProvider>(
          builder: (context, dashBoradProvider, child) {
        if (dashBoradProvider.artistList.isNotEmpty) {
          if (dashBoradProvider.datanotfound)
            NoDataFoundErrorScreens(
              height: 50.h,
            );

          return ArtistUI(
            con: widget.con,
            artistdata: dashBoradProvider.artistList,
            languagelist: widget.languagelist,
          );
        } else {
          return LoaderScreens();
        }
      }),
    );
  }
}
