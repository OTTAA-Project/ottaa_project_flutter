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
      icon: Icon(Icons.chevron_left), onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return FutureBuilder<SearchModel?>(
      future: _editController.fetchPhotoFromArsaac(text: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            color: Colors.black,
            child: GridView.builder(
              // controller: _pictogramController.pictoGridController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: snapshot.data!.symbols.length,
              itemBuilder: (context, index) => Container(
                child: GestureDetector(
                  onTap: () async {
                    _editController.selectedPhotoUrl.value =
                        snapshot.data!.symbols[index].imagePNGURL;
                    Get.back();
                  },
                  child: Image.network(
                    snapshot.data!.symbols[index].imagePNGURL,
                    width: horizontalSize * 0.1,
                  ),
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
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Future<void> onTap(Pict pict) async {
    /// grab the link for the picto from here
  }
}
