import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_widgets/otta_icons.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

final List<PageViewerDataModel> data = [
  PageViewerDataModel(
    text: 'sentence_1',
    icon: Icons.videogame_asset,
  ),
  PageViewerDataModel(
    text: 'sentence_3',
    icon: OttaIcons.map_marked,
  ),
  PageViewerDataModel(
    text: 'sentence_2',
    icon: Icons.accessible_forward,
  ),
];

class LeftSidePaidVersion extends GetView<HomeController> {
  const LeftSidePaidVersion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(verticalSize * 0.01),
        ),
        child: PageView.builder(
          itemCount: 3,
          controller: controller.pageController,
          itemBuilder: (context, index) => PageViewerItem(
            text: data[controller.currentPage].text.tr,
            icon: data[controller.currentPage].icon,
          ),
        ),
      ),
    );
  }
}

class PageViewerItem extends StatelessWidget {
  const PageViewerItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Icon(
            icon,
            color: kOTTAAOrangeNew,
            size: verticalSize * 0.5,
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class PageViewerDataModel {
  final String text;
  final IconData icon;

  PageViewerDataModel({
    required this.text,
    required this.icon,
  });
}
