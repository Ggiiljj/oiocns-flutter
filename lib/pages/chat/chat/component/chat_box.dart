import 'dart:math';

import 'package:audio_wave/audio_wave.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orginone/components/a_font.dart';
import 'package:orginone/components/unified_colors.dart';
import 'package:orginone/dart/controller/message/chat_box_controller.dart';
import 'package:orginone/dart/controller/message/message_controller.dart';
import 'package:orginone/util/permission_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

double defaultBorderRadius = 6.w;
double boxDefaultHeight = 40.h;
double defaultBottomHeight = 300.h;

class ChatBox extends GetView<ChatBoxController> with WidgetsBindingObserver {
  final RxDouble bottomHeight = defaultBottomHeight.obs;

  ChatBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget voiceFunc = Obx(() {
      if (controller.inputStatus == InputStatus.voice) {
        return _leftKeyBoardBtn(context);
      } else {
        return _voiceBtn(context);
      }
    });
    Widget otherFunc = Obx(() {
      switch (controller.inputStatus) {
        case InputStatus.notPopup:
        case InputStatus.focusing:
        case InputStatus.voice:
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_emojiBtn(context), _moreBtn(context)],
          );
        case InputStatus.emoji:
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_keyBoardBtn(context), _moreBtn(context)],
          );
        case InputStatus.more:
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_emojiBtn(context), _moreBtn(context)],
          );
        case InputStatus.inputtingText:
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_emojiBtn(context), _sendBtn(context)],
          );
        case InputStatus.inputtingEmoji:
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_keyBoardBtn(context), _sendBtn(context)],
          );
      }
    });
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      var bottom = MediaQuery.of(context).viewInsets.bottom;
      var inputStatus = controller.inputStatus;
      if (inputStatus == InputStatus.focusing ||
          inputStatus == InputStatus.notPopup ||
          inputStatus == InputStatus.voice ||
          inputStatus == InputStatus.inputtingText) {
        bottomHeight.value = bottom;
      }
    });
    return Container(
      color: UnifiedColors.navigatorBgColor,
      padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 10.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [voiceFunc, _input(context), otherFunc],
          ),
          _bottomPopup(context),
        ],
      ),
    );
  }

  /// 麦克风权限
  _permissionMicrophone(BuildContext context, Function callback) {
    Permission.microphone.request().then((permissionStatus) {
      try {
        if (permissionStatus != PermissionStatus.granted) {
          throw RecordingPermissionException(
              "Microphone permission not granted");
        }
      } on RecordingPermissionException {
        PermissionUtil.showPermissionDialog(context, Permission.microphone);
      }
      callback();
    });
  }

  /// 输入
  Widget _input(BuildContext context) {
    return Expanded(child: Obx(() {
      if (controller.inputStatus == InputStatus.voice) {
        return _voice(context);
      }
      return _inputBox(context);
    }));
  }

  /// 输入框
  Widget _inputBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
      ),
      alignment: Alignment.center,
      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        focusNode: controller.focusNode,
        onChanged: (text) =>
            controller.eventFire(context, InputEvent.clickInput),
        onTap: () => controller.eventFire(context, InputEvent.clickInput),
        style: AFont.instance.size22Black3W500,
        controller: controller.inputController,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 16.h),
          border: InputBorder.none,
          constraints: BoxConstraints(
            maxHeight: 144.h,
          ),
        ),
      ),
    );
  }

  /// 录音按钮
  Widget _voice(BuildContext context) {
    var voiceWave = OverlayEntry(builder: (BuildContext context) {
      return _voiceWave();
    });
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      onLongPressMoveUpdate: (details) async {
        var localPosition = details.localPosition;
        if (localPosition.dy < 0) {
          await controller.pauseRecord();
        } else {
          await controller.resumeRecord();
        }
      },
      onLongPress: () {
        _permissionMicrophone(context, () {
          controller.startRecord().then((value) async {
            Vibration.hasVibrator()
                .then((value) => Vibration.vibrate(duration: 100));
            Overlay.of(context)!.insert(voiceWave);
          });
        });
      },
      onLongPressEnd: (details) async {
        voiceWave.remove();

        var recordStatus = controller.recordStatus.value;
        if (recordStatus == RecordStatus.recoding) {
          // 记录
          var duration = controller.currentDuration ?? Duration.zero;
          await controller.stopRecord();
          if (duration.inMilliseconds < 2000) {
            Fluttertoast.showToast(msg: '时间太短啦!');
            return;
          }

          var path = controller.currentFile;
          var time = duration.inMilliseconds;
          if (Get.isRegistered<MessageController>()) {
            var messageCtrl = Get.find<MessageController>();
            messageCtrl.sendVoice(path!, time);
          }
        } else if (recordStatus == RecordStatus.pausing) {
          // 停止记录
          await controller.stopRecord();
          Fluttertoast.showToast(msg: "取消成功!");
        }
      },
      child: Container(
        height: 36.h + 22.sp,
        margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        alignment: Alignment.center,
        child: Obx(() {
          var recordStatus = controller.recordStatus.value;
          switch (recordStatus) {
            case RecordStatus.stop:
              return const Text("按住 说话");
            case RecordStatus.recoding:
              return const Text("松开 发送");
            case RecordStatus.pausing:
              return const Text("上移 取消",
                  style: TextStyle(color: UnifiedColors.backColor));
          }
        }),
      ),
    );
  }

  /// 表情包按钮
  Widget _emojiBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.eventFire(context, InputEvent.clickEmoji),
      child: _rightIcon(Icons.emoji_emotions_outlined),
    );
  }

  /// 更多操作
  Widget _moreBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.eventFire(context, InputEvent.clickMore),
      child: _rightIcon(Icons.add),
    );
  }

  /// 语音按钮
  Widget _voiceBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.eventFire(context, InputEvent.clickVoice);
        _permissionMicrophone(context, controller.openRecorder);
      },
      child: _leftIcon(Icons.settings_voice_outlined),
    );
  }

  /// 键盘按钮
  Widget _leftKeyBoardBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.eventFire(context, InputEvent.clickKeyBoard),
      child: _leftIcon(Icons.keyboard_alt_outlined),
    );
  }

  /// 键盘按钮
  Widget _keyBoardBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.eventFire(context, InputEvent.clickKeyBoard),
      child: _rightIcon(Icons.keyboard_alt_outlined),
    );
  }

  // 左侧 Icon
  Widget _leftIcon(IconData iconData) {
    return Container(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 8.w),
      child: Icon(
        iconData,
        size: boxDefaultHeight,
      ),
    );
  }

  /// 右侧 Icon
  Widget _rightIcon(IconData iconData) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, top: 8.h, bottom: 8.h),
      child: Icon(
        iconData,
        size: boxDefaultHeight,
      ),
    );
  }

  /// 发送按钮
  Widget _sendBtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      child: ElevatedButton(
        onPressed: () => controller.eventFire(context, InputEvent.clickSendBtn),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
          minimumSize: MaterialStateProperty.all(Size(10.w, boxDefaultHeight)),
        ),
        child: const Text("发送"),
      ),
    );
  }

  /// 下面的弹出框
  Widget _bottomPopup(BuildContext context) {
    return Obx(() {
      late Widget body;
      switch (controller.inputStatus) {
        case InputStatus.emoji:
        case InputStatus.inputtingEmoji:
          bottomHeight.value = defaultBottomHeight;
          body = _emojiPicker(context);
          break;
        case InputStatus.more:
          bottomHeight.value = defaultBottomHeight;
          body = _more(context);
          break;
        case InputStatus.notPopup:
        case InputStatus.voice:
          return Container();
        case InputStatus.focusing:
        case InputStatus.inputtingText:
          body = Container();
          FocusScope.of(context).requestFocus(controller.focusNode);
          break;
      }
      return Offstage(
        offstage: false,
        child: Obx(() => SizedBox(height: bottomHeight.value, child: body)),
      );
    });
  }

  /// 表情包选择
  Widget _emojiPicker(BuildContext context) {
    var inputController = controller.inputController;
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        inputController
          ..text += emoji.emoji
          ..selection = TextSelection.fromPosition(
            TextPosition(
              offset: inputController.text.length,
            ),
          );
        controller.eventFire(context, InputEvent.inputEmoji);
      },
    );
  }

  /// 更多功能
  Widget _more(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      child: GridView.count(
        shrinkWrap: true,
        mainAxisSpacing: 10.w,
        scrollDirection: Axis.vertical,
        crossAxisCount: 4,
        children: MoreFunction.values
            .map((item) => _funcIcon(item, context))
            .toList(),
      ),
    );
  }

  /// 功能点
  Widget _funcIcon(MoreFunction moreFunction, BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.execute(moreFunction, context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.w)),
            ),
            margin: EdgeInsets.only(bottom: 10.h),
            child: Icon(moreFunction.iconData),
          ),
          Text(moreFunction.label, style: AFont.instance.size16Black3W500)
        ],
      ),
    );
  }

  /// 录音波动
  Widget _voiceWave() {
    Random random = Random();
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter - const Alignment(0.0, -0.5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Obx(() {
              var recordStatus = controller.recordStatus.value;
              if (recordStatus == RecordStatus.recoding) {
                // 处于录音状态
                double value = controller.level?.value ?? 0;
                double maxValue = controller.maxLevel ?? 0;

                double randomPercent = 0.3;
                double percent = maxValue == 0 ? 1 : value / maxValue;
                percent = percent - randomPercent;
                Color color = UnifiedColors.white;

                // 坡数量，波浪数量
                int peakCount = 8;
                int waveCount = 32;
                int averagePeakCount = waveCount ~/ peakCount;
                double average = peakCount / waveCount;

                List<AudioWaveBar> bars = [];
                for (int i = 0; i <= waveCount; i++) {
                  bool isEven = ((i ~/ averagePeakCount) % 2) == 0;
                  int heightCount = i % averagePeakCount;
                  double randomHeight = random.nextDouble() * randomPercent;
                  if (isEven) {
                    var height = heightCount * average * percent + randomHeight;
                    height = height < 0 ? 0 : height;
                    bars.add(AudioWaveBar(heightFactor: height, color: color));
                  } else {
                    var remainder = averagePeakCount - heightCount;
                    var height = remainder * average * percent + randomHeight;
                    height = height < 0 ? 0 : height;
                    bars.add(AudioWaveBar(heightFactor: height, color: color));
                  }
                }
                return AudioWave(
                  animation: false,
                  bars: bars,
                );
              } else if (recordStatus == RecordStatus.pausing) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: UnifiedColors.backColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  ),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_return,
                        color: Colors.white,
                        size: 50.w,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.h)),
                      Text("取消发送", style: AFont.instance.size22WhiteW500)
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
          ),
        ),
      ],
    );
  }
}
