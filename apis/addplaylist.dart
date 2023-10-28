import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';

class AddPlayListApi {
  final Map<String, dynamic> body;
  AddPlayListApi(this.body);

  Future addToPlaylist() async {
    Service service = new Service(APIURL.AddPlaylist, body);
    var data = await service.formdata();
    return data;
  }
}
