import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/provider/profileuserprovider.dart';
import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/home/home.dart';
import 'package:ancientmysticmusic/screen/profile/musicdownloads.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatefulWidget {
  final MainController con;

  const ProfileScreen({Key? key, required this.con}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignUpScreen = true;

  ProfileUserProvider _profileuserProvider = ProfileUserProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileuserProvider =
        Provider.of<ProfileUserProvider>(context, listen: false);
    _profileuserProvider.profileuserlist(MyApp.email_VALUE ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: Consumer<ProfileUserProvider>(
          builder: ((context, profileUserProvider, child) {
        return SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 2.h,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {}, // Image tapped
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 8.h,
                    backgroundImage:
                        profileUserProvider.profileuserList.isNotEmpty
                            ? profileUserProvider.profileuserList[0].image != ''
                                ? NetworkImage(profileUserProvider
                                    .profileuserList[0].image
                                    .toString())
                                : AssetImage(ImageFile.profile) as ImageProvider
                            : AssetImage(ImageFile.profile),
                  ),
                ),
                SizedBox(
                  height: 0.2.h,
                ),
                Center(
                  child: Text(
                      profileUserProvider.profileuserList.isNotEmpty
                          ? profileUserProvider.profileuserList[0].firstName ??
                              ''
                          : '',
                      style: Style_File.title.copyWith(color: colorWhite)),
                ),
              ],
            ),
            Center(
                child: Text("Mr. Smyth",
                    style: Style_File.title.copyWith(color: colorPrimary))),
            SizedBox(
              height: 1.h,
            ),
            Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 2.0.h, top: 2.0.h, bottom: 2.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Downloads",
                        style: Style_File.title.copyWith(color: colorPrimary)),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 5.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                    //color: colorPrimary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 3.0.h, top: 1.0.h, bottom: 1.0.h, right: 3.0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sr. No",
                            style: Style_File.subtitle
                                .copyWith(color: colorWhite)),
                        Text("Downloaded On",
                            style: Style_File.subtitle
                                .copyWith(color: colorWhite)),
                        Text("Song/Album",
                            style: Style_File.subtitle
                                .copyWith(color: colorWhite)),
                        Text("Price",
                            style: Style_File.subtitle
                                .copyWith(color: colorWhite)),
                        Text("Action",
                            style: Style_File.subtitle
                                .copyWith(color: colorWhite)),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 35.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.0.h),
                      child: MusicDownloads(),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.0.h, top: 2.0.h, bottom: 2.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Recent Activity",
                      style: Style_File.title.copyWith(color: colorPrimary)),
                ],
              ),
            ),
          ]),
        );
      })),
    );
  }
}
