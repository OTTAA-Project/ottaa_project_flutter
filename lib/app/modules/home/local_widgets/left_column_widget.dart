import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/empty_text_dialog_widget.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/utils/CustomAnalytics.dart';

class LeftColumnWidget extends StatelessWidget {
  LeftColumnWidget({Key? key}) : super(key: key);
  final _homeController = Get.find<HomeController>();

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
          FittedBox(
            child: GestureDetector(
              onTap: () async {
                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   barrierColor: Colors.transparent,
                //   builder: (context) {
                //     return EmptyTextDialogWidget(
                //       text: "we_are_working_on_this_feature".tr,
                //     );
                //   },
                // );
                // await _homeController.startTimerForDialogueExit();
                // CustomAnalyticsEvents.setEventWithParameters("Touch",
                //     CustomAnalyticsEvents.createMyMap('Principal', 'Games'));
                // Get.toNamed(AppRoutes.GAMES);
                final ref = FirebaseDatabase.instance.ref();
                final re = ref.child('test/');
                dynamic jsonData = List.empty(growable: true);
                // todo: for saving pictos
                // _homeController.picts.forEach((Pict e) {
                //   final relactions = e.relacion?.map((e) => e.toJson()).toList();
                //   jsonData.add(
                //     {
                //     'id': e.id,
                //     'texto' : e.texto.toJson(),
                //     'tipo': e.tipo,
                //     'imagen': e.imagen.toJson(),
                //     'relacion': relactions,
                //     'agenda': e.agenda,
                //     'gps': e.gps,
                //     'hora' : e.hora,
                //     'edad':e.edad,
                //     'sexo': e.sexo,
                //     'esSugerencia': e.esSugerencia,
                //     'horario':e.horario,
                //     'ubicacion' : e.ubicacion,
                //     'score' : e.score,
                //     }
                //   );
                // });
                // _homeController.grupos.forEach((e) {
                //   final relactions = e.relacion.map((e) => e.toJson()).toList();
                //   jsonData.add({
                //   'id': e.id,
                //   'texto': e.texto.toJson(),
                //   'tipo': e.tipo,
                //   'imagen': e.imagen.toJson(),
                //   'relacion' : relactions,
                //   'frecuencia':e.frecuencia,
                //   'tags': e.tags,
                //   });
                // });
                // re.set(jsonData);
                final data = await re.once();
                final encode = jsonEncode(data.snapshot.value);
                final da = (jsonDecode(encode) as List)
                    .map((e) => Pict.fromJson(e))
                    .toList();
                da[0].texto.en = 'tasks';
                da[0].texto.es = 'tasks';
                final relactions =
                    da[0].relacion?.map((e) => e.toJson()).toList();
                final ree = ref.child('test/0/');
                ree.update({
                  'id': da[0].id,
                  'texto': da[0].texto.toJson(),
                  'tipo': da[0].tipo,
                  'imagen': da[0].imagen.toJson(),
                  'relacion': relactions,
                  'agenda': da[0].agenda,
                  'gps': da[0].gps,
                  'hora': da[0].hora,
                  'edad': da[0].edad,
                  'sexo': da[0].sexo,
                  'esSugerencia': da[0].esSugerencia,
                  'horario': da[0].horario,
                  'ubicacion': da[0].ubicacion,
                  'score': da[0].score,
                });
                print('done');
              },
              child: Center(
                  child: Icon(
                // Icons.gamepad,
                Icons.videogame_asset,
                color: Colors.white,
                size: horizontalSize / 12,
              )),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                CustomAnalyticsEvents.setEventWithParameters(
                    "Touch",
                    CustomAnalyticsEvents.createMyMap(
                        'Principal', 'Group Galery'));
                if (_homeController.sentencePicts.isEmpty) {
                  Get.toNamed(AppRoutes.PICTOGRAMGROUP);
                } else {
                  if (_homeController.sentencePicts.last.texto.es ==
                      "agregar") {
                    _homeController.toId = 0;
                    _homeController.fromAdd = true;
                    Get.toNamed(AppRoutes.PICTOGRAMGROUP);
                  } else {
                    _homeController.toId =
                        _homeController.sentencePicts.last.id;
                    _homeController.fromAdd = true;
                    Get.toNamed(AppRoutes.PICTOGRAMGROUP);
                  }
                }
              },
              child: Center(
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                  size: horizontalSize / 10,
                ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: kOTTAAOrangeNew,
        borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
      ),
    );
  }

// static toOrderItemList(var map) {
//   Map values = map as Map;
//   List<Pict> cartItem = [];
//   values.forEach((key, data) {
//     final Pict connect = Pict.fromJson(data);
//     cartItem.add(connect);
//   });
//   return cartItem;
// }
}
