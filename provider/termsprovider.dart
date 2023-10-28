import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/model/termsModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsProvider extends ChangeNotifier {
  TermsModel termsModel = TermsModel();

  List<TermsData> _termslist = [];
  List<TermsData> get termsList => _termslist;

  bool datanotfound = false;

  Future termslist() async {
    ServiceWithoutbody _service =
        new ServiceWithoutbody(APIURL.TERMSCONDITIONS);
    final response = await _service.data();

    termsModel = TermsModel.fromJson(response);
    if (termsModel.data != null) {
      _termslist = [];
      _termslist.add(termsModel.data!);

      print('object about $_termslist');
      notifyListeners();
    }

    return;
  }
}
