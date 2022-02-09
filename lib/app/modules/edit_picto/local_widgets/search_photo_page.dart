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
    return FutureBuilder<SearchModel?>(
      future: _editController.fetchPhotoFromArsaac(text: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.symbols[index].name),
                leading:
                    Image.network(snapshot.data!.symbols[index].imagePNGURL),
                onTap: () {
                  close(context, snapshot.data!);
                },
              );
            },
            itemCount: snapshot.data!.symbols.length,
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
