import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orginone/components/a_font.dart';
import 'package:orginone/components/form_item_type1.dart';
import 'package:orginone/components/unified_scaffold.dart';
import 'package:orginone/config/field_config.dart';
import 'package:orginone/dart/controller/target/target_controller.dart';
import 'package:orginone/pages/other/search/search_controller.dart';
import 'package:orginone/routers.dart';
import 'package:orginone/util/widget_util.dart';

class MineUnitPage extends GetView<TargetController> {
  const MineUnitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnifiedScaffold(
      appBarTitle: Text("我的单位", style: AFont.instance.size22Black3),
      appBarCenterTitle: true,
      appBarLeading: WidgetUtil.defaultBackBtn,
      bgColor: const Color.fromRGBO(240, 240, 240, 1),
      floatingButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: FloatingActionButton(
              heroTag: 'one',
              onPressed: () async {
                Get.toNamed(
                  Routers.maintain,
                  arguments: CreateCompany((value) {
                    if (Get.isRegistered<TargetController>()) {
                      var targetCtrl = Get.find<TargetController>();
                      targetCtrl
                          .createCompany(value)
                          .then((value) => Get.back());
                    }
                  }),
                );
              },
              tooltip: "创建单位",
              backgroundColor: Colors.blueAccent,
              splashColor: Colors.white,
              elevation: 0.0,
              highlightElevation: 25.0,
              child: const Icon(Icons.add, size: 30, color: Colors.white),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: FloatingActionButton(
              onPressed: () {
                Map<String, dynamic> params = {
                  "items": [SearchItem.units],
                  "point": FunctionPoint.applyCompanies,
                };
                Get.toNamed(Routers.search, arguments: params);
              },
              tooltip: "加入单位",
              backgroundColor: Colors.blueAccent,
              splashColor: Colors.white,
              elevation: 0.0,
              highlightElevation: 25.0,
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Obx(() {
          var companies = controller.currentPerson.joinedCompanies;
          return ListView.builder(
            itemCount: companies.length,
            itemBuilder: (BuildContext context, int index) {
              var company = companies[index];
              return FormItemType1(
                leftSlot: CircleAvatar(
                  foregroundImage: const NetworkImage(
                      'https://www.vcg.com/creative/1382429598'),
                  backgroundImage: const AssetImage('images/person_empty.png'),
                  onForegroundImageError: (error, stackTrace) {},
                  radius: 15,
                ),
                title: company.target.code,
                text: company.target.name,
                suffixIcon: const Icon(Icons.keyboard_arrow_right),
                callback1: () {
                  controller.setCurrentMaintain(company);
                  Get.toNamed(Routers.unitDetail, arguments: 1);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
