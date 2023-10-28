import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/model/aboutModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutProvider extends ChangeNotifier {
  AboutModel aboutModel = AboutModel();

  List<AboutData> _aboutlist = [];
  List<AboutData> get aboutList => _aboutlist;
  bool datanotfound = false;
  Future aboutlist() async {
    ServiceWithoutbody _service = new ServiceWithoutbody(APIURL.ABOUT);
    final response = await _service.data();

    aboutModel = AboutModel.fromJson(response);
    if (aboutModel.data != null) {
      _aboutlist = [];
      _aboutlist.add(aboutModel.data!);
      // for (int i = 0; i < aboutModel.data!.length; i++) {
      //   _aboutlist.add(aboutModel.data!);
      // }
      print('object about $_aboutlist');
      notifyListeners();
    }

    return;
  }
}
