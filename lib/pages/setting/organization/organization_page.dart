import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:orginone/components/choose_item.dart';
import 'package:orginone/components/icon_avatar.dart';
import 'package:orginone/components/unified_colors.dart';
import 'package:orginone/components/unified_edge_insets.dart';
import 'package:orginone/components/unified_text_style.dart';
import 'package:orginone/dart/core/authority.dart';
import 'package:orginone/pages/setting/organization/organization_controller.dart';
import 'package:orginone/routers.dart';

class OrganizationPage extends GetView<OrganizationController> {
  const OrganizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrganizationController>(
      init: controller,
      builder: (controller) {
        List<Widget> items = [];
        // 好友管理，群组管理
        items.add(_friends);
        items.add(_cohorts);
        // 集团管理，单位管理
        if (auth.isCompanySpace()) {
          items.add(_groups);
          items.add(_unit);
        }
        return ListView(children: items);
      },
    );
  }

  get _friends => ChooseItem(
        header: const IconAvatar(
          icon: Icon(
            Icons.group,
            color: Colors.white,
          ),
        ),
        body: Container(
          margin: left10,
          child: Text("我的好友", style: text16Bold),
        ),
        func: () {
          Get.toNamed(Routers.friends);
        },
      );

  get _cohorts => ChooseItem(
        header: const IconAvatar(
          icon: Icon(
            Icons.group,
            color: Colors.white,
          ),
        ),
        body: Container(
          margin: left10,
          child: Text("我的群组", style: text16Bold),
        ),
        func: () {
          Get.toNamed(Routers.cohorts);
        },
      );

  get _groups => ChooseItem(
        header: const IconAvatar(
          icon: Icon(
            Icons.group_add_sharp,
            color: Colors.white,
          ),
        ),
        body: Container(
          margin: left10,
          child: Text("我的集团", style: text16Bold),
        ),
        func: () {
          Get.toNamed(Routers.groups);
        },
      );

  get _unit {
    return ChooseItem(
      header: const IconAvatar(
        icon: Icon(
          Icons.account_tree,
          color: Colors.white,
        ),
      ),
      body: Expanded(
        child: Container(
          margin: left10,
          child: Text(
            auth.spaceInfo.name,
            style: text16Bold,
          ),
        ),
      ),
      func: () {
        Get.toNamed(Routers.units);
      },
      operate: GFButton(
        size: GFSize.SMALL,
        color: UnifiedColors.darkGreen,
        textColor: Colors.white,
        onPressed: () async {},
        text: "邀请",
      ),
      content: [
        ChooseItem(
          header: IconAvatar(
            icon: const Icon(
              Icons.subdirectory_arrow_right,
              color: Colors.black,
            ),
            bgColor: Colors.white.withOpacity(0),
          ),
          body: Container(
            margin: left10,
            child: Text("组织架构", style: text16Bold),
          ),
          padding: const EdgeInsets.only(left: 10, top: 10),
          func: () {
            Get.toNamed(Routers.dept);
          },
        )
      ],
    );
  }
}
