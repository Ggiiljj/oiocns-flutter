import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:orginone/components/a_font.dart';
import 'package:orginone/components/unified_colors.dart';
import 'package:orginone/components/unified_scaffold.dart';
import 'package:orginone/dart/base/enumeration/target_type.dart';
import 'package:orginone/dart/base/model/message_detail.dart';
import 'package:orginone/dart/base/model/message_target.dart';
import 'package:orginone/dart/base/model/target.dart';
import 'package:orginone/dart/controller/message/chat_box_controller.dart';
import 'package:orginone/dart/controller/message/message_controller.dart';
import 'package:orginone/dart/core/authority.dart';
import 'package:orginone/pages/chat/chat/component/chat_box.dart';
import 'package:orginone/pages/chat/components/chat_message_detail.dart';
import 'package:orginone/routers.dart';
import 'package:orginone/main.dart';
import 'package:orginone/util/date_util.dart';
import 'package:orginone/util/widget_util.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> with RouteAware {
  final MessageController messageCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return UnifiedScaffold(
      appBarHeight: 74.h,
      appBarBgColor: UnifiedColors.navigatorBgColor,
      resizeToAvoidBottomInset: false,
      appBarLeading: WidgetUtil.defaultBackBtn,
      appBarTitle: _title,
      appBarCenterTitle: true,
      appBarActions: _actions,
      body: _body(context),
    );
  }

  get _title {
    return Obx(() {
      var chat = messageCtrl.getCurrentChat;
      var messageItem = chat!.target;
      String name = messageItem.name;
      if (messageItem.typeName != TargetType.person.label) {
        name += "(${chat.personCount})";
      }
      String spaceName = "${chat.spaceName} | ${messageItem.label}";
      return Column(
        children: [
          Text(name, style: AFont.instance.size22Black3),
          Text(spaceName, style: AFont.instance.size14Black9),
        ],
      );
    });
  }

  get _actions => <Widget>[
        GFIconButton(
          color: Colors.white.withOpacity(0),
          icon: Icon(
            Icons.more_horiz,
            color: UnifiedColors.black3,
            size: 32.w,
          ),
          onPressed: () async {
            var chat = messageCtrl.getCurrentChat!;
            await messageCtrl.setCurrentSetting(chat.spaceId, chat.chatId);
            Get.toNamed(Routers.messageSetting);
          },
        ),
      ];

  Widget _time(DateTime? dateTime) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      child: Text(
        dateTime != null ? CustomDateUtil.getDetailTime(dateTime) : "",
        style: AFont.instance.size16Black9,
      ),
    );
  }

  Widget _chatItem(int index) {
    var chat = messageCtrl.getCurrentChat!;
    MessageTarget messageItem = chat.target;
    MessageDetail messageDetail = chat.messages[index];

    Target userInfo = auth.userInfo;
    bool isMy = messageDetail.fromId == userInfo.id;
    bool isMultiple = messageItem.typeName != TargetType.person.label;

    Widget currentWidget = ChatMessageDetail(
      detail: messageDetail,
      isMy: isMy,
      isMultiple: isMultiple,
    );

    var time = _time(messageDetail.createTime);
    var item = Column(children: [currentWidget]);
    if (index == 0) {
      item.children.add(Container(margin: EdgeInsets.only(bottom: 5.h)));
    }
    if (index == chat.messages.length - 1) {
      item.children.insert(0, time);
      return item;
    } else {
      MessageDetail pre = chat.messages[index + 1];
      if (messageDetail.createTime != null && pre.createTime != null) {
        var difference = messageDetail.createTime!.difference(pre.createTime!);
        if (difference.inSeconds > 60 * 3) {
          item.children.insert(0, time);
          return item;
        }
      }
      return item;
    }
  }

  Widget _body(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        ChatBoxController chatBoxController = Get.find<ChatBoxController>();
        chatBoxController.eventFire(context, InputEvent.clickBlank);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              color: UnifiedColors.bgColor,
              child: RefreshIndicator(
                onRefresh: () => messageCtrl.getCurrentChat!.moreMessage(),
                child: Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Obx(
                    () => ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      controller: messageCtrl.messageScrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: messageCtrl.getCurrentChat!.messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _chatItem(index);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          ChatBox()
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute); //订阅
    super.didChangeDependencies();
  }

  @override
  void didPop() {
    super.didPop();
    messageCtrl.setCurrentNull();
  }
}
