import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orginone/components/a_font.dart';
import 'package:orginone/components/unified_colors.dart';
import 'package:orginone/components/unified_scaffold.dart';
import 'package:orginone/dart/controller/message/message_controller.dart';
import 'package:orginone/dart/core/authority.dart';
import 'package:orginone/pages/setting/organization/cohorts/component/avatar_group.dart';
import 'package:orginone/routers.dart';
import 'package:orginone/util/widget_util.dart';

class MoreCohort extends GetView<MessageController> {
  const MoreCohort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnifiedScaffold(
      appBarTitle: Text("群组人员", style: AFont.instance.size22Black3),
      appBarCenterTitle: true,
      appBarLeading: WidgetUtil.defaultBackBtn,
      appBarElevation: 0,
      body: Container(
        color: UnifiedColors.bgColor,
        child: ListView(
          children: [
            Obx(() {
              var chat = controller.getCurrentSetting!;
              var isRelationAdmin = auth.isRelationAdmin([chat.target.id]);
              return AvatarGroup(
                persons: controller.settingPersons,
                hasAdd: isRelationAdmin,
                padding: EdgeInsets.only(top: 30.h),
                addCallback: () {
                  Map<String, dynamic> args = {
                    "spaceId": chat.spaceId,
                    "messageItemId": chat.chatId,
                  };
                  Get.toNamed(Routers.invite, arguments: args);
                },
              );
            }),
            Obx(() {
              var chat = controller.getCurrentSetting!;
              if (chat.hasMorePersons()) {
                return _more;
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }

  get _more {
    var chat = controller.getCurrentSetting!;
    return GestureDetector(
      onTap: () => chat.morePersons(),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 40.h),
        child: Text(
          "查看更多",
          style: AFont.instance.size20themeColorW500,
        ),
      ),
    );
  }
}
