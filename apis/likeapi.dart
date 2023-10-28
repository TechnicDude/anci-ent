import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';

class LikeApi {
  final Map<String, dynamic> body;
  LikeApi(this.body);

  Future likealbum() async {
    Service service = new Service(APIURL.STORELIKE, body);
    var data = await service.formdata();
    return data;
  }

  Future dislikealbum() async {
    Service service = new Service(APIURL.DeleteLike, body);
    var data = await service.formdata();
    return data;
  }

  Future recentlyPlayedadd() async {
    Service service = new Service(APIURL.RecentlyPlayedAdd, body);
    var data = await service.formdata();
    return data;
  }
}
