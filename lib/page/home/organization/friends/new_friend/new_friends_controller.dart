import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orginone/page/home/message/message_controller.dart';
import 'package:orginone/public/http/base_list_controller.dart';
import 'package:orginone/public/loading/opt_loading.dart';

import '../../../../../api/person_api.dart';
import '../../../../../api_resp/friends_entity.dart';

class NewFriendsController extends BaseListController<FriendsEntity> {
  int limit = 20;
  int offset = 0;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  @override
  void onLoadMore() async {
    offset += 1;
    var pageResp = await PersonApi.approvalAll("0", limit, offset);
    addData(true, pageResp);
  }

  @override
  void onRefresh() async {
    var pageResp = await PersonApi.approvalAll("0", limit, offset);
    addData(true, pageResp);
  }

  String getName(String userId) {
    MessageController find = Get.find<MessageController>();
    var orgChatCache = find.orgChatCache;
    String name = "";
    if (orgChatCache != null &&
        orgChatCache.nameMap != null &&
        orgChatCache.nameMap.isNotEmpty) {
      name = (orgChatCache.nameMap[userId]) ?? "";
    }
    return name;
  }

  void joinSuccess(String id) async {
    ALoading.showCircle();
    await PersonApi.joinSuccess(id).then((value) {
      //成功，刷新列表
      Fluttertoast.showToast(msg: "已通过");
      offset = 0;
      onRefresh();
    }).onError((error, stackTrace) {
    }).whenComplete(() => ALoading.dismiss());
  }

  void joinRefuse(String id) async {
    ALoading.showCircle();
    await PersonApi.joinRefuse(id).then((value) {
      //成功，刷新列表
      offset = 0;
      onRefresh();
    }).onError((error, stackTrace) {
    }).whenComplete(() => ALoading.dismiss());
  }
}
