import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/sentences_provider.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_logo_widget.dart';

class AddOrRemoveFavouritePage extends ConsumerWidget {
  const AddOrRemoveFavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    final provider = ref.watch(sentencesProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('favourite_sentences'.trl),
        actions: [
          GestureDetector(
            onTap: () {
              //todo: go back to the previous screen
              // Get.back();
            },
            child: const Icon(
              Icons.favorite,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: kOTTAAOrangeNew,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        GestureDetector(
                          onTap: () {
                            //todo: go back to previous screen
                            // Get.back();
                          },
                          child: Icon(
                            Icons.cancel,
                            size: verticalSize * 0.1,
                            color: Colors.white,
                          ),
                        ),

                        /// for keeping them in order and the button will be in separate Positioned
                        Container(),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: kOTTAAOrangeNew,
                                  ),
                                );
                              },
                            );
                            await provider.saveFavourite();
                            //todo: go back to the sentences screen
                            // Get.back();
                            // Get.back();
                          },
                          child: Icon(
                            Icons.save,
                            size: verticalSize * 0.1,
                            color: Colors.white,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: verticalSize * 0.3,
              child: Container(
                height: verticalSize * 0.5,
                width: horizontalSize * 0.8,
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalSize * 0.12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      provider.favouriteOrNotPicts.isNotEmpty
                          ? Container(
                              height: verticalSize / 2.5,
                              width: horizontalSize * 0.78,
                              color: provider
                                      .sentences[
                                          provider.selectedIndexFavSelection]
                                      .favouriteOrNot
                                  ? Colors.blue
                                  : Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  vertical: verticalSize * 0.05),
                              child: Center(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider
                                          .favouriteOrNotPicts[provider
                                              .selectedIndexFavSelection]
                                          .length +
                                      1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Pict speakPict = Pict(
                                      localImg: true,
                                      id: 0,
                                      texto: Texto(),
                                      tipo: 6,
                                      imagen: Imagen(picto: "logo_ottaa_dev"),
                                    );
                                    if (provider
                                            .favouriteOrNotPicts[provider
                                                .selectedIndexFavSelection]
                                            .length >
                                        index) {
                                      final Pict pict =
                                          provider.favouriteOrNotPicts[provider
                                                  .selectedIndexFavSelection]
                                              [index];
                                      return Container(
                                        margin: const EdgeInsets.all(10),
                                        child: MiniPicto(
                                          localImg: pict.localImg,
                                          pict: pict,
                                          onTap: () {
                                            provider
                                                    .sentences[provider
                                                        .selectedIndexFavSelection]
                                                    .favouriteOrNot =
                                                !provider
                                                    .sentences[provider
                                                        .selectedIndexFavSelection]
                                                    .favouriteOrNot;
                                            provider.speakFavOrNot();
                                          },
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: const EdgeInsets.all(10),
                                        child: MiniPicto(
                                          localImg: speakPict.localImg,
                                          pict: speakPict,
                                          onTap: () {
                                            provider
                                                    .sentences[provider
                                                        .selectedIndexFavSelection]
                                                    .favouriteOrNot =
                                                !provider
                                                    .sentences[provider
                                                        .selectedIndexFavSelection]
                                                    .favouriteOrNot;
                                            provider.speakFavOrNot();
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),

            ///circularProgressIndicator
            provider.showCircular
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kOTTAAOrangeNew,
                    ),
                  )
                : Container(),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: kOTTAAOrangeNew,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                  ),
                ),
                width: horizontalSize * 0.10,
                height: verticalSize * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      //todo: add the required code
                      provider.selectedIndexFavSelection--;
                    },
                    child: Icon(
                      Icons.skip_previous,
                      size: verticalSize * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: kOTTAAOrangeNew,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                  ),
                ),
                width: horizontalSize * 0.10,
                height: verticalSize * 0.5,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      //todo: add teh required call
                      provider.selectedIndexFavSelection++;
                    },
                    child: Icon(
                      Icons.skip_next,
                      size: verticalSize * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: verticalSize * 0.02,
              left: horizontalSize * 0.43,
              right: horizontalSize * 0.43,
              child: GestureDetector(
                onTap: () async {
                  //todo: add the required call
                  await provider.speakFavOrNot();
                },
                child: OttaaLogoWidget(
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
