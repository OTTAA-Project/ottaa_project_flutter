import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_controller.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class SearchPhotoGroup extends SearchDelegate<String?> {
  SearchPhotoGroup({
    this.edit = false,
  });

  final _editController = Get.find<PictogramGroupsController>();
  final _homeController = Get.find<HomeController>();
  bool edit;

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(
            Icons.clear,
          ),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return FutureBuilder<List<SearchModel?>>(
      future: _editController.fetchPhotoFromGlobalSymbols(text: query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          print(snapshot.toString());
          return Text(
            snapshot.stackTrace.toString(),
            style: const TextStyle(fontSize: 100),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          snapshot.data!.removeWhere((element) => element!.picto.nativeFormat == 'svg');
          _homeController.dataMainForImages.clear();
          _homeController.dataMainForImages = snapshot.data!;
          print('might be from here');
          print(_homeController.dataMainForImages.length);
          _homeController.dataMainForImagesReferences = _homeController.dataMainForImages;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: verticalSize * 0.02,
                ),
                HeaderWidget(),
                Expanded(
                  child: Obx(
                    () => _editController.refreshSearchResult.value
                        ? GridView.builder(
                            shrinkWrap: true,
                            // controller: _pictogramController.pictoGridController,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: _homeController.dataMainForImagesReferences.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.white,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (edit) {
                                      _editController.selectedPhotoUrlGrupoEdit.value = _homeController.dataMainForImagesReferences[index]!.picto.imageUrl;
                                      _editController.editingGrupo.value = true;
                                      _editController.imageWidgetGrupoEdit.value = null;
                                    } else {
                                      _editController.selectedPhotoUrlGrupo.value = _homeController.dataMainForImagesReferences[index]!.picto.imageUrl;
                                      _editController.isImageProvidedGrupo.value = true;
                                      _editController.imageWidgetPicto.value = null;
                                      _editController.imageWidgetGrupo.value = null;
                                    }
                                    // _editController.imageWidget.value = null;
                                    Get.back();
                                    Get.back();
                                  },
                                  child: Image.network(
                                    _homeController.dataMainForImagesReferences[index]!.picto.imageUrl,
                                    width: horizontalSize * 0.1,
                                  ),
                                ),
                              );
                            },
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 1,
                            ),
                          )
                        : Container(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}

class HeaderWidget extends StatelessWidget {
  HeaderWidget({Key? key}) : super(key: key);
  final _editController = Get.find<PictogramGroupsController>();
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return SizedBox(
      height: verticalSize * 0.05,
      width: horizontalSize,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: Padding ??
          Container(
            decoration: const BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
            child: Center(
              child: Text(
                'Dataset',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: verticalSize * 0.02,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _editController.dataSetMapId.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                child: GestureDetector(
                  onTap: () {
                    _editController.selectedId.value = _editController.dataSetMapId[index]!;
                    print('after change id is ${_editController.selectedId.value} : ${_editController.dataSetMapId[index]!}');
                    if (_editController.selectedId.value == 0) {
                      _homeController.dataMainForImagesReferences.clear();
                      _homeController.dataMainForImagesReferences.addAll(_homeController.dataMainForImages);
                      print('here is the number ${_homeController.dataMainForImagesReferences.length}');
                    } else {
                      final dataImages = _homeController.dataMainForImages;
                      print('the length for main images id ${_homeController.dataMainForImages.length}');
                      List<SearchModel?> toBeShown = [];
                      for (var dataImage in dataImages) {
                        if (dataImage!.picto.symbolsetId == _editController.selectedId.value) {
                          toBeShown.add(dataImage);
                        }
                      }
                      _homeController.dataMainForImagesReferences = toBeShown;
                    }
                    _editController.refreshSearchResult.value = !_editController.refreshSearchResult.value;
                    _editController.refreshSearchResult.value = !_editController.refreshSearchResult.value;
                  },
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: _editController.selectedId.value == _editController.dataSetMapId[index]! ? kOTTAAOrangeNew : Colors.grey,
                        borderRadius: BorderRadius.circular(horizontalSize * 0.015),
                      ),
                      width: horizontalSize * 0.12,
                      child: Center(
                        child: Text(
                          '${_editController.dataSetMapStrings[_editController.dataSetMapId[index]]}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//TODO: DRY [search_photo_picto.dart]