import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class RightColumnWidget extends StatelessWidget {
  RightColumnWidget({Key? key}) : super(key: key);
  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Container(
      height: verticalSize * 0.5,
      width: horizontalSize * 0.10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /*FittedBox(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.CONFIGURATION);
              },
              child: Center(
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: horizontalSize / 10,
                ),
              ),
            ),
          ),*/
          FittedBox(
            child: GestureDetector(
              onTap: () async {
                //todo: take the algo from here and optimize it
                final directory = await getExternalStorageDirectory();
                print(directory!.path);
                final file = File('${directory.path}/counter.json');
                List<String> gruposInFile = [];
                _controller.grupos.forEach((element) {
                  final obj = jsonEncode(element);
                  gruposInFile.add(obj);
                });
                print(gruposInFile.length);
                print(_controller.grupos.length);
                // print(gruposInFile.toString());
                await file.writeAsString(gruposInFile.toString());
                final response = await file.readAsString();
                final res = (jsonDecode(response) as List)
                    .map((e) => Grupos.fromJson(e))
                    .toList();
                // final re = jsonDecode(decoded[0]);
                // print(re);
                print(res.length);
                print(res[0].texto.es);
                print(_controller.grupos[0].texto.es);
              },
              child: Center(
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: horizontalSize / 10,
                ),
              ),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.SENTENCES);
              },
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: horizontalSize / 10,
                ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: kOTTAOrangeNew,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(horizontalSize / 40),
        ),
      ),
    );
  }
}
