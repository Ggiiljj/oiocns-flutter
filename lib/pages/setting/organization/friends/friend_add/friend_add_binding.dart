import 'package:get/get.dart';
import 'package:orginone/pages/setting/organization/friends/friend_add/friend_add_controller.dart';

class FriendAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendAddController());
  }
}
