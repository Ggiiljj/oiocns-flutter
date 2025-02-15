import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:orginone/components/unified_colors.dart';
import 'package:orginone/routers.dart';
import 'package:orginone/util/hive_util.dart';
import 'package:orginone/util/notification_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  FlutterBugly.postCatchedException(() async {
    // 逻辑绑定
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化 hive
    await HiveUtil().init();

    // 初始化通知配置
    NotificationUtil.initNotification();

    // 日志初始化
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((event) {
      if (kDebugMode) {
        print('${event.level.name}: ${event.time}: ${event.message}');
      }
    });

    await AppServer.initialization();

    // 开启 app
    runApp(const ScreenInit());

    // 日志收集工具
    FlutterBugly.init(
      androidAppId: "e36da6d5e9",
      iOSAppId: "af89f332-ed6c-42dc-8eb1-fb63cea1a39d",
    );
  }, debugUpload: true);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver();
const Size screenSize = Size(540, 1170);

class ScreenInit extends StatelessWidget {
  const ScreenInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return RefreshConfiguration(
          footerTriggerDistance: 15,
          dragSpeedRatio: 0.91,
          headerBuilder: () => const MaterialClassicHeader(
            color: UnifiedColors.themeColor,
          ),
          footerBuilder: () => const ClassicFooter(
              loadingText: "努力加载中...",
              idleText: "上拉加载更多...",
              canLoadingText: "上拉加载更多",
              noDataText: "没有更多了",
              failedText: "点击重试"),
          enableLoadingWhenNoData: false,
          enableRefreshVibrate: false,
          enableLoadMoreVibrate: false,
          shouldFooterFollowWhenNotFull: (state) {
            return false;
          },
          child: GetMaterialApp(
            navigatorObservers: [routeObserver],
            navigatorKey: navigatorKey,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate, //iOS
            ],
            supportedLocales: const [
              Locale('zh', 'CN'),
              Locale('en', 'US'),
            ],
            textDirection: TextDirection.ltr,
            initialRoute: Routers.main,
            getPages: Routers.getInitRouters(),
          ),
        );
      },
    );
  }
}
