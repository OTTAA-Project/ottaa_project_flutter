import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';

import 'local_widgets/category_widget.dart';

class CustomDelegate extends SearchDelegate<String> {
  final _pictogramController = Get.find<PictogramGroupsController>();
  final _ttsController = Get.find<TTSController>();
  final _homeController = Get.find<HomeController>();

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.chevron_left), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Pict> listToShow;
    final language = _ttsController.languaje;
    if (query.isNotEmpty)
      listToShow = language == 'en'
          ? _pictogramController.picts
              .where((e) =>
                  e.texto.en.contains(query) && e.texto.en.startsWith(query))
              .toList()
          : _pictogramController.picts
              .where((e) =>
                  e.texto.es.contains(query) && e.texto.es.startsWith(query))
              .toList();
    else
      listToShow = _pictogramController.picts;

    return Container(
      color: Colors.black,
      child: GridView.builder(
        // controller: _pictogramController.pictoGridController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: listToShow.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () async {
            await onTap(listToShow[index]);
          },
          child: CategoryWidget(
            name: language == 'en'
                ? listToShow[index].texto.en
                : listToShow[index].texto.es,
            imageName: listToShow[index].imagen.picto,
            border: true,
            bottom: false,
            color: listToShow[index].tipo,
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
        ),
      ),
    );
  }

  Future<void> onTap(Pict pict) async {
    //saying the name after selecting the category
    _ttsController.speak(pict.texto.en);
    //add to the sentence
    await _homeController.addPictToSentence(pict);
    Get.back();
    Get.back();
  }
}
