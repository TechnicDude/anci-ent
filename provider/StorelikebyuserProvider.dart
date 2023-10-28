import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/model/StorelikebyuserModel.dart';
import 'package:flutter/cupertino.dart';

class ProfileUserProvider extends ChangeNotifier {
  StorelikebyuserModel storelikebyuserModel = StorelikebyuserModel();

  List<StorelikebyuserData> _storelikebyuserlist = [];
  List<StorelikebyuserData> get storelikebyuserList => _storelikebyuserlist;

  Future storelikebyuserlist(
    String user_id,
  ) async {
    // print("object data");
    var data = {
      'id': user_id,
    };
    Service _service = new Service(APIURL.STORELIKEBYUSER, data);
    final response = await _service.formdata();
    // print(response);
    _storelikebyuserlist = [];
    storelikebyuserModel = StorelikebyuserModel.fromJson(response);
    if (storelikebyuserModel.data != null) {
      var storelikebyuser = storelikebyuserModel.data;

      _storelikebyuserlist.add(storelikebyuser!);

      notifyListeners();
    }
  }
}
