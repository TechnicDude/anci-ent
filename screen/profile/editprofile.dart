import 'dart:convert';
import 'dart:io';
import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/loginapi.dart';
import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/profileuserModel.dart';
import 'package:ancientmysticmusic/utils/button_widget.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:ancientmysticmusic/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final List<ProfileUserData>? profileuserdata;

  const EditProfileScreen({Key? key, this.profileuserdata}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameeditcontroller = new TextEditingController();
  TextEditingController _phoneeditcontroller = new TextEditingController();
  TextEditingController _emaileditcontroller = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.profileuserdata!.isNotEmpty) {
      _emaileditcontroller.text = widget.profileuserdata![0].email ?? '';
      _nameeditcontroller.text = widget.profileuserdata![0].firstName ?? '';
      _phoneeditcontroller.text = widget.profileuserdata![0].contact ?? '';
    }
    super.initState();
  }

  Future submitupdate() async {
    if (imagefiles != null) {
      var url = Uri.parse(APIURL.ProfileUpdate);

      final request = new http.MultipartRequest('POST', url);
      print(imagefiles!.path);

      final file = await http.MultipartFile.fromPath('image', imagefiles!.path);

      request.files.add(file);

      request.fields['first_name'] = _nameeditcontroller.text;
      request.fields['contact'] = _phoneeditcontroller.text;
      request.fields['email'] = _emaileditcontroller.text;
      request.fields['id'] = MyApp.userid!;
      try {
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        print(response.body);
        var out = jsonDecode(response.body);
        if (out['status'] == "true") {
          DialogHelper.showFlutterToast(strMsg: out['message']);
          Navigator.pop(context);
        }
      } catch (e) {
        print(e);
      }
    } else {
      var data = {
        'first_name': _nameeditcontroller.text,
        'contact': _phoneeditcontroller.text,
        'email': _emaileditcontroller.text,
        "id": MyApp.userid,
      };
      print(data.toString());
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.updateprofile();
      print(response);
      if (response['status'] == "true") {
        DialogHelper.showFlutterToast(strMsg: response['message']);
        Navigator.pop(context);
      }
    }
  }

  final ImagePicker imgpicker = ImagePicker();
  XFile? imagefiles;
  openImages() async {
    try {
      final XFile? image =
          await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture

      if (image != null) {
        imagefiles = image;
        setState(() {});
      } else {
        print("No image is selected.");
        DialogHelper.showFlutterToast(strMsg: 'No image is selected.');
      }
    } catch (e) {
      print("Error while picking file.");
      DialogHelper.showFlutterToast(strMsg: 'Error while picking file');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      appBar: AppBar(title: Text("My Profile")),
      body: Padding(
        padding: EdgeInsets.only(top: 1.h, left: 2.h, right: 2.h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 6.h,
                    backgroundImage: imagefiles != null
                        ? FileImage(File(imagefiles!.path))
                        : widget.profileuserdata![0].image != null
                            ? NetworkImage(APIURL.imageurl +
                                widget.profileuserdata![0].image.toString())
                            : AssetImage(ImageFile.profile
                                // "assets/images/profile.png",
                                ) as ImageProvider,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          //_editProfileController.showPopupMenu();
                          openImages();
                        },
                        child: CircleAvatar(
                          radius: 2.h,
                          backgroundColor: colorPrimary,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 2.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Name",
                        style: Style_File.title.copyWith(color: colorPrimary)),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormScreen(
                  hinttext: "Enter Name",
                  textEditingController: _nameeditcontroller,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Phone",
                        style: Style_File.title.copyWith(color: colorPrimary)),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormScreen(
                  hinttext: "Enter Phone",
                  textEditingController: _phoneeditcontroller,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email",
                        style: Style_File.title.copyWith(color: colorPrimary)),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormScreen(
                  hinttext: "Enter Email",
                  textEditingController: _emaileditcontroller,
                ),
                SizedBox(
                  height: 3.h,
                ),
                ButtonWidget(
                  text: 'SAVE',
                  onTap: () {
                    submitupdate();
                  },
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
