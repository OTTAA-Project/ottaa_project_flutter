import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/data/models/search_model.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_controller.dart';

class SearchPhotoPage extends SearchDelegate<SearchModel?> {
  final _editController = Get.find<EditPictoController>();

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return FutureBuilder<List<SearchModel?>>(
      future: _editController.fetchPhotoFromArsaac(text: query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          print(snapshot.toString());
          return Text(
            snapshot.stackTrace.toString(),
            style: TextStyle(fontSize: 100),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          snapshot.data!
              .removeWhere((element) => element!.picto.nativeFormat == 'svg');
          return Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
            color: Colors.black,
            child: GridView.builder(
              // controller: _pictogramController.pictoGridController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () async {
                      _editController.selectedPhotoUrl.value =
                          snapshot.data![index]!.picto.imageUrl;
                      _editController.editingPicture.value = true;
                      Get.back();
                      Get.back();
                    },
                    child: Image.network(
                      snapshot.data![index]!.picto.imageUrl,
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
            ),
          );
        } else {
          return Container(
            color: Colors.black,
            child: Center(
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

  Future<void> onTap(Pict pict) async {
    /// grab the link for the picto from here
  }
}
