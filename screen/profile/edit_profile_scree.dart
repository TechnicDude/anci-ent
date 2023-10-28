// import 'package:ancientmysticmusic/apis/loginapi.dart';
// import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
// import 'package:ancientmysticmusic/model/profileuserModel.dart';
// import 'package:ancientmysticmusic/utils/colors.dart';
// import 'package:ancientmysticmusic/utils/string_file.dart';
// import 'package:ancientmysticmusic/utils/style_file.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class EditProfileScreen extends StatefulWidget {
//   final List<ProfileUserData>? profileuserdata;
//   const EditProfileScreen({Key? key, this.profileuserdata}) : super(key: key);
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   TextEditingController _nameeditcontroller = new TextEditingController();
//   TextEditingController _phoneeditcontroller = new TextEditingController();
//   TextEditingController _emaileditcontroller = new TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     // TODO: implement initState
//     if (widget.profileuserdata!.isNotEmpty) {
//       _emaileditcontroller.text = widget.profileuserdata![0].email ?? '';
//       _nameeditcontroller.text = widget.profileuserdata![0].firstName ?? '';
//       _phoneeditcontroller.text = widget.profileuserdata![0].lastName ?? '';
//     }
//     super.initState();
//   }

//   Future submitupdate() async {
//     var data = {
//       'email': _emaileditcontroller.text,
//       'name': _nameeditcontroller.text,
//       'mobile': _phoneeditcontroller.text,
//     };
//     print(data.toString());
//     LoginApi registerresponse = LoginApi(data);
//     final response = await registerresponse.updateprofile();
//     print(response);
//     if (response['status'] == "true") {
//       DialogHelper.showFlutterToast(strMsg: response['message']);
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: colorPrimary,
//           centerTitle: true,
//           title: Text(
//             "Edit Profile",
//             style: TextStyle(
//               color: colorWhite,
//               // fontFamily: Contants().FONT_KEY_NAME_AMAZON,
//               // fontSize: isMobile(context)
//               //     ? MyFontSize().mediumTextSizeMobile
//               //     : MyFontSize().mediumTextSizeTablet,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Center(
//                       child: CircleAvatar(
//                         radius: 40,
//                         backgroundImage: AssetImage(
//                           "assets/images/placeholder.png",
//                         ),
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: InkWell(
//                             onTap: () {
//                               // _editProfileController.showPopupMenu();
//                             },
//                             child: const CircleAvatar(
//                               radius: 15,
//                               backgroundColor: colorSecondry,
//                               child: Icon(
//                                 Icons.edit,
//                                 color: Colors.white,
//                                 size: 15,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Text(
//                       StringFile.name,
//                       textAlign: TextAlign.center,
//                       style: Style_File.title,
//                     ),
//                     Container(
//                         width: 100.w,
//                         height: 45,
//                         padding: const EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           color: colorWhite,
//                           borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                           border: Border.all(color: colorGrey, width: 1),
//                         ),
//                         child: TextField(
//                           controller: _nameeditcontroller,
//                           textAlign: TextAlign.start,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         )),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       StringFile.contact,
//                       style: Style_File.title,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Container(
//                         width: 100.w,
//                         height: 45,
//                         padding: const EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                           color: colorWhite,
//                           borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                           border: Border.all(color: colorGrey, width: 1),
//                         ),
//                         child: TextField(
//                           controller: _phoneeditcontroller,
//                           keyboardType: TextInputType.phone,
//                           textAlign: TextAlign.start,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         )),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       StringFile.email,
//                       style: Style_File.title,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Container(
//                       width: 100.w,
//                       height: 45,
//                       padding: const EdgeInsets.all(5.0),
//                       decoration: BoxDecoration(
//                         color: colorWhite,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(5.0)),
//                         border: Border.all(color: colorGrey, width: 1),
//                       ),
//                       child: TextField(
//                         controller: _emaileditcontroller,
//                         readOnly: true,
//                         keyboardType: TextInputType.emailAddress,
//                         textAlign: TextAlign.start,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           submitupdate();
//                         },
//                         child: Text(
//                           StringFile.submit.toUpperCase(),
//                           style: TextStyle(
//                             color: colorWhite,
//                             // fontFamily: Contants().FONT_KEY_NAME_AMAZON,
//                             // fontSize: isMobile(context)
//                             //     ? MyFontSize().mediumTextSizeMobile
//                             //     : MyFontSize().mediumTextSizeTablet
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                             fixedSize: Size(100.w / 2.5, 45),
//                             primary: colorPrimary,
//                             shape: const RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5.0)))),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
