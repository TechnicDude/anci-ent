import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/model/privacyModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyProvider extends ChangeNotifier {
  PrivacyModel privacyModel = PrivacyModel();

  List<PrivacyData> _privacylist = [];
  List<PrivacyData> get privacyList => _privacylist;

  bool datanotfound = false;

  Future privacylist() async {
    ServiceWithoutbody _service = new ServiceWithoutbody(APIURL.PRIVACYPOLICY);
    final response = await _service.data();

    privacyModel = PrivacyModel.fromJson(response);
    if (privacyModel.data != null) {
      _privacylist = [];
      _privacylist.add(privacyModel.data!);

      print('object about $_privacylist');
      notifyListeners();
    }

    return;
  }
}
