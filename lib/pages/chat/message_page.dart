import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orginone/components/a_font.dart';
import 'package:orginone/components/choose_item.dart';
import 'package:orginone/components/icon_avatar.dart';
import 'package:orginone/components/text_avatar.dart';
import 'package:orginone/components/text_tag.dart';
import 'package:orginone/components/unified_colors.dart';
import 'package:orginone/components/unified_edge_insets.dart';
import 'package:orginone/components/unified_text_style.dart';
import 'package:orginone/dart/base/model/tree_node.dart';
import 'package:orginone/dart/controller/message/message_controller.dart';
import 'package:orginone/dart/controller/target/target_controller.dart';
import 'package:orginone/dart/core/authority.dart';
import 'package:orginone/pages/chat/components/message_item_widget.dart';
import 'package:orginone/routers.dart';
import 'package:orginone/util/string_util.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 60.h,
        child: TabBar(
          controller: controller.tabController,
          tabs: controller.tabs.map((item) => item.body!).toList(),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 2.h),
        child: Divider(height: 1.h),
      ),
      Expanded(
        child: TabBarView(
          controller: controller.tabController,
          children: controller.tabs.map((item) => item.tabView).toList(),
        ),
      )
    ]);
  }
}

class RecentChat extends GetView<MessageController> {
  const RecentChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int chatSize = controller.getChatSize();
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: chatSize + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < chatSize) {
            var chat = controller.chats[index];
            return MessageItemWidget(
              chat: chat,
              remove: controller.removeChat,
            );
          }
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routers.moreMessage);
            },
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 30.h)),
                Text("更多会话", style: AFont.instance.size18themeColorW500),
                Padding(padding: EdgeInsets.only(top: 30.h)),
              ],
            ),
          );
        },
      );
    });
  }
}

class Relation extends GetView<MessageController> {
  const Relation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _relation();
  }

  Widget _relation() {
    List<Widget> children = [];
    children.addAll(_recent());
    children.add(Padding(padding: EdgeInsets.only(top: 10.h)));
    children.add(Divider(height: 1.h));
    children.add(Padding(padding: EdgeInsets.only(top: 10.h)));
    children.add(_tree());
    children.add(_links());
    return Container(
      margin: EdgeInsets.only(left: 25.w, right: 25.w),
      child: Column(children: children),
    );
  }

  Widget _tree() {
    return Obx(() {
      double leftWidth = 60.w;

      // 选择项
      List<Widget> body = [];
      body.add(ChooseItem(
        padding: EdgeInsets.zero,
        header: Container(
          alignment: Alignment.center,
          width: leftWidth,
          child: TextTag(
            auth.isUserSpace() ? "个人" : "单位",
            padding: EdgeInsets.all(4.w),
            textStyle: AFont.instance.size12themeColor,
            borderColor: UnifiedColors.themeColor,
            bgColor: Colors.white,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text(
            auth.spaceInfo.name,
            style: AFont.instance.size22Black3W700,
          ),
        ),
        func: () {
          if (auth.isUserSpace()) {
            Get.toNamed(Routers.friends);
          } else {
            Get.toNamed(Routers.dept, arguments: auth.spaceId);
          }
        },
      ));

      if (Get.isRegistered<TargetController>() && auth.isCompanySpace()) {
        var targetCtrl = Get.find<TargetController>();
        NodeCombine? nodeCombine = targetCtrl.currentCompany.tree;
        if (nodeCombine != null) {
          TreeNode topNode = nodeCombine.topNode;
          var children = topNode.children;
          double top = 16.h;
          if (children.isNotEmpty) {
            body.add(Padding(padding: EdgeInsets.only(top: top)));
            body.add(_deptItem(children[0], leftWidth));
            if (children.length > 1) {
              body.add(Padding(padding: EdgeInsets.only(top: top)));
              body.add(_deptItem(children[1], leftWidth));
              if (children.length > 2) {
                body.add(Padding(padding: EdgeInsets.only(top: top)));
                body.add(_more(leftWidth));
              }
            }
          }
        }
      }
      return Column(children: body);
    });
  }

  Widget _links() {
    double top = 12.h;
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: top)),
        _otherUnits,
        Padding(padding: EdgeInsets.only(top: top)),
        // _chats,
        // Padding(padding: EdgeInsets.only(top: top)),
        Divider(height: 1.h),
        Padding(padding: EdgeInsets.only(top: top)),
        _newFriends,
        // Padding(padding: EdgeInsets.only(top: top)),
        // _specialFocus,
        Padding(padding: EdgeInsets.only(top: top)),
        _myRelation,
        Padding(padding: EdgeInsets.only(top: top)),
        _myCohort,
      ],
    );
  }

  List<Widget> _recent() {
    double avatarWidth = 60.w;
    return [
      Container(margin: EdgeInsets.only(top: 4.h)),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("最近联系", style: AFont.instance.size20Black3W500),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routers.moreMessage);
            },
            child: Text("更多会话", style: AFont.instance.size18themeColorW500),
          )
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 10.h),
        height: avatarWidth,
        child: Obx(
          () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.getChatSize(),
            itemBuilder: (context, index) {
              var chat = controller.chats[index];
              return GestureDetector(
                onTap: () async {
                  bool success = await controller.setCurrentByChat(chat);
                  if (!success) {
                    Fluttertoast.showToast(msg: "未获取到会话信息！");
                    return;
                  }
                  Get.toNamed(Routers.chat);
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.w)),
                  ),
                  margin: EdgeInsets.only(right: 15.w),
                  child: TextAvatar(
                    width: avatarWidth,
                    avatarName: StringUtil.getPrefixChars(
                      chat.target.name,
                      count: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      )
    ];
  }

  Widget _deptItem(TreeNode treeNode, double leftWidth) {
    return ChooseItem(
      padding: EdgeInsets.zero,
      header: Container(
        alignment: Alignment.centerRight,
        width: leftWidth,
        child: const Icon(Icons.arrow_right),
      ),
      body: Container(
        margin: left10,
        child: Text(treeNode.label, style: text18),
      ),
      func: () {
        Get.toNamed(Routers.dept, arguments: treeNode.id);
      },
    );
  }

  Widget _more(double leftWidth) {
    return ChooseItem(
      padding: EdgeInsets.zero,
      header: Container(width: leftWidth),
      body: Container(
        margin: left10,
        child: Text("更多", style: text16),
      ),
      func: () {
        Get.toNamed(Routers.dept);
      },
    );
  }

  Widget _header(IconData icon) {
    return IconAvatar(
      width: 60.w,
      icon: Icon(icon, color: Colors.white),
      padding: EdgeInsets.zero,
    );
  }

  get _otherUnits => ChooseItem(
        padding: EdgeInsets.zero,
        header: _header(Icons.group),
        body: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text("其他单位", style: AFont.instance.size22Black3W500),
        ),
        func: () {
          Get.toNamed(Routers.mineUnit);
        },
      );

  get _chats => ChooseItem(
        padding: EdgeInsets.zero,
        header: _header(Icons.group),
        body: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text("奥集能通讯录", style: AFont.instance.size22Black3W500),
        ),
        func: () {},
      );

  get _newFriends => ChooseItem(
        padding: EdgeInsets.zero,
        header: _header(Icons.group),
        body: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text("新朋友", style: AFont.instance.size22Black3W500),
        ),
        func: () {
          Get.toNamed(Routers.newFriends);
        },
      );

  get _specialFocus => ChooseItem(
        padding: EdgeInsets.zero,
        header: _header(Icons.group),
        body: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text("特别关注", style: AFont.instance.size22Black3W500),
        ),
        func: () {},
      );

  get _myRelation => ChooseItem(
        padding: EdgeInsets.zero,
        header: _header(Icons.group),
        body: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text("我的联系人", style: AFont.instance.size22Black3W500),
        ),
        func: () {
          Get.toNamed(Routers.contact);
        },
      );

  get _myCohort => ChooseItem(
        padding: EdgeInsets.zero,
        header: _header(Icons.group),
        body: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text("我的群组", style: AFont.instance.size22Black3W500),
        ),
        func: () {
          var targetCtrl = Get.find<TargetController>();
          targetCtrl.currentPerson.loadJoinedCohorts().then((value) {
            targetCtrl.searchedCohorts.clear();
            targetCtrl.searchedCohorts
                .addAll(targetCtrl.currentPerson.joinedCohorts);
          });
          Get.toNamed(Routers.cohorts);
        },
      );
}
