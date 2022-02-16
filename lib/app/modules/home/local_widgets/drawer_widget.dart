import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

import '../../about/about_ottaa_page.dart';

class DrawerWidget extends GetView<HomeController> {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalSize * 0.02),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: verticalSize * 0.01),
          width: horizontalSize * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(verticalSize * 0.03),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kOTTAOrangeNew,
                  borderRadius: BorderRadius.circular(verticalSize * 0.027),
                ),
                height: verticalSize * 0.15,
                width: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => Image.asset(
                          'assets/profiles/Group ${controller.picNumber.value}@2x.png',
                          height: verticalSize * 0.05,
                        ),
                      ),
                      Image.asset(
                        'assets/otta_drawer_logo.png',
                        height: verticalSize * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: verticalSize * 0.01,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTileWidget(
                      icon: Icons.location_on,
                      title: 'Location',
                      onTap: () async {},
                    ),
                    ListTileWidget(
                      icon: Icons.volume_up,
                      title: 'Mute',
                      onTap: () async {},
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                // thickness: 0.0,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTileWidget(
                      icon: Icons.info_outline,
                      title: 'About OTTAA',
                      onTap: () => Get.toNamed(AppRoutes.ABOUTOTTAA),
                    ),
                    ListTileWidget(
                      icon: Icons.view_compact,
                      title: 'Generate Report',
                      onTap: () async {},
                    ),
                    ListTileWidget(
                      icon: Icons.settings,
                      title: 'Configuration',
                      onTap: () => Get.toNamed(AppRoutes.SETTINGS),
                    ),
                    ListTileWidget(
                      icon: Icons.info_outline,
                      title: 'Tutorial',
                      onTap: () async {
                        Get.toNamed(AppRoutes.TUTORIAL);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                // thickness: 0.0,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTileWidget(
                      icon: Icons.highlight_remove,
                      title: 'Close Application',
                      onTap: () async {
                        exit(0);
                      },
                    ),
                    ListTileWidget(
                      icon: Icons.exit_to_app,
                      title: 'Sign out',
                      onTap: () async {
                        await controller.authController.signOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  ListTileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: verticalSize * 0.035,
      ),
      title: Text(
        title,
      ),
    );
  }
}
