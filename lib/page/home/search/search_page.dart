import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';
import 'package:getwidget/components/tabs/gf_tabbar_view.dart';
import 'package:orginone/component/unified_scaffold.dart';
import 'package:orginone/component/unified_text_style.dart';

import '../../../../util/widget_util.dart';
import '../../../api_resp/target_resp.dart';
import '../../../component/text_avatar.dart';
import '../../../component/text_search.dart';
import '../../../component/unified_colors.dart';
import '../../../enumeration/target_type.dart';
import '../../../util/string_util.dart';
import 'search_controller.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMultiple = controller.searchItems.length > 1;
    bool isSingle = controller.searchItems.length == 1;
    Column body = Column(children: [TextSearch(controller.searchingCallback)]);
    if (isMultiple) {
      body.children.addAll([_tabBar(context), _tabView()]);
    } else if (isSingle) {
      SearchItem searchItem = controller.searchItems[0];
      switch (searchItem) {
        case SearchItem.friends:
          body.children.add(_targetBody(TargetType.person));
          break;
        case SearchItem.applications:
          break;
        case SearchItem.comprehensive:
          break;
        case SearchItem.cohorts:
          break;
        case SearchItem.messages:
          break;
        case SearchItem.documents:
          break;
        case SearchItem.logs:
          break;
        case SearchItem.labels:
          break;
        case SearchItem.functions:
          break;
        case SearchItem.departments:
          break;
        case SearchItem.publicCohorts:
          break;
        case SearchItem.units:
          body.children.add(_targetBody(TargetType.company));
          break;
      }
    }

    return UnifiedScaffold(
      appBarLeading: WidgetUtil.defaultBackBtn,
      appBarTitle:
          Text(controller.functionPoint?.functionName ?? "搜索", style: text20),
      appBarCenterTitle: true,
      body: body,
    );
  }

  Widget _tabBar(BuildContext context) {
    List<Widget> tabs = controller.searchItems
        .map((item) => Text(item.name, style: text12))
        .toList();

    return GFTabBar(
        width: 1000,
        tabBarHeight: 40,
        indicatorColor: Colors.blueAccent,
        tabBarColor: UnifiedColors.easyGrey,
        length: controller.tabController.length,
        controller: controller.tabController,
        tabs: tabs);
  }

  Widget _tabView() {
    return GFTabBarView(
      height: 400,
      controller: controller.tabController,
      children: controller.searchItems
          .map((item) => Container(
                alignment: Alignment.center,
                child: Text(item.name),
              ))
          .toList(),
    );
  }

  Widget _targetBody(TargetType targetType) {
    return GetBuilder<SearchController>(
      builder: (item) {
        List<TargetResp> searchResults = [];
        switch (targetType) {
          case TargetType.person:
            searchResults = controller.personRes?.searchResults ?? [];
            break;
          case TargetType.company:
            searchResults = controller.companyRes?.searchResults ?? [];
            break;
          case TargetType.cohort:
            break;
          case TargetType.department:
            break;
        }
        return Expanded(
          child: ListView.builder(
            controller: controller.scrollController,
            itemCount: searchResults.length,
            itemBuilder: (BuildContext context, int index) {
              return _targetItem(searchResults[index]);
            },
          ),
        );
      },
    );
  }

  Widget _targetItem(TargetResp targetResp) {
    List<Widget> children = [
      TextAvatar(
        avatarName: StringUtil.getAvatarName(
          avatarName: targetResp.name,
          type: TextAvatarType.chat,
        ),
      ),
      Container(margin: EdgeInsets.only(left: 10.w)),
      Expanded(child: Text(targetResp.name, style: text16Bold)),
    ];
    if (controller.functionPoint != null) {
      switch (controller.functionPoint!) {
        case FunctionPoint.addFriends:

          break;
      }
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 10.w, bottom: 10.h, right: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}