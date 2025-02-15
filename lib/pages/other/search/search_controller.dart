import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:orginone/dart/base/api/cohort_api.dart';
import 'package:orginone/dart/base/api/company_api.dart';
import 'package:orginone/dart/base/api/person_api.dart';
import 'package:orginone/dart/base/model/target.dart';

enum SearchItem {
  comprehensive("综合", []),
  friends("好友", [FunctionPoint.addFriends]),
  cohorts("群组", [FunctionPoint.applyCohorts]),
  messages("消息", []),
  documents("文档", []),
  logs("日志", []),
  labels("文本", []),
  functions("功能", []),
  departments("部门", []),
  publicCohorts("公开群组", []),
  applications("应用", []),
  markets("市场", []),
  units("单位", [FunctionPoint.applyCompanies]);

  const SearchItem(this.label, this.functionPoint);

  final String label;
  final List<FunctionPoint> functionPoint;
}

enum FunctionPoint {
  addFriends("添加好友", "通过账号/手机号搜索"),
  applyCohorts("申请入群", "通过群组编号搜索"),
  applyCompanies("申请入单位", "通过单位编号搜索"),
  ;

  const FunctionPoint(this.functionName, this.placeHolder);

  final String functionName;
  final String placeHolder;
}

enum SearchStatus { stop, searching }

class SearchController extends GetxController with GetTickerProviderStateMixin {
  final Logger log = Logger("SearchController");

  late TabController tabController;
  late List<SearchItem> searchItems;
  FunctionPoint? functionPoint;
  ScrollController scrollController = ScrollController();

  // 搜索的一些结果
  SearchParams<Target>? personRes;
  SearchParams<Target>? cohortRes;
  SearchParams<Target>? companyRes;

  // 搜索状态
  Rx<SearchStatus> searchStatus = SearchStatus.stop.obs;

  // 动画
  late AnimationController animationController;

  @override
  void onInit() {
    Map<String, dynamic> args = Get.arguments ?? {};
    searchItems = args["items"] ?? SearchItem.values;
    functionPoint = args["point"];

    tabController = TabController(length: searchItems.length, vsync: this);
    const duration = Duration(seconds: 1);
    animationController = AnimationController(vsync: this, duration: duration);
    animationController.repeat();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    animationController.dispose();
  }

  Future<void> searchingCallback(String filter) async {
    searchStatus.value = SearchStatus.searching;
    update();
    try {
      switch (searchItems[tabController.index]) {
        case SearchItem.friends:
          personRes = SearchParams();
          var pageResp = await PersonApi.searchPersons(
            keyword: filter,
            limit: personRes!.limit,
            offset: personRes!.offset,
          );
          log.info(pageResp.result);
          var result = pageResp.result;
          personRes!.offset = result.length;
          personRes!.searchResults = result;
          update();
          break;
        case SearchItem.applications:
          break;
        case SearchItem.comprehensive:
          break;
        case SearchItem.cohorts:
          cohortRes = SearchParams();
          var pageResp = await CohortApi.search(
            keyword: filter,
            limit: cohortRes!.limit,
            offset: cohortRes!.offset,
          );
          log.info(pageResp.result);
          var result = pageResp.result;
          cohortRes!.offset = result.length;
          cohortRes!.searchResults = result;
          update();
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
          companyRes = SearchParams();
          var pageResp = await CompanyApi.searchCompanys(
            keyword: filter,
            limit: companyRes!.limit,
            offset: companyRes!.offset,
          );
          var result = pageResp.result;
          companyRes!.offset = result.length;
          companyRes!.searchResults = result;
          update();
          break;
        case SearchItem.markets:
          break;
      }
    } finally {
      searchStatus.value = SearchStatus.stop;
    }
  }
}

class SearchParams<T> {
  List<T> searchResults = [];
  int limit = 20;
  int offset = 0;
}
