import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/sentences_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_logo_widget.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

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

        /// that one time when getx was high on weed and was not doing the translations
        title: Text('favourite_sentences'.trl),
        actions: [
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.addOrRemoveFavouriteSentences);
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
            Container(
              child: Column(
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
                              context.pop();
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
                            onTap: () {
                              context.push(AppRoutes.addOrRemoveFavouriteSentences);
                            },
                            child: Icon(
                              Icons.edit,
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
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: verticalSize * 0.17,
              child: Container(
                height: verticalSize * 0.8,
                width: horizontalSize * 0.8,
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalSize * 0.099),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
                  child: Center(
                    //todo: update the view according to the things
                    child: SizedBox(
                      height: verticalSize * 0.8,
                      width: horizontalSize * 0.8,
                      // padding: EdgeInsets.symmetricmmetric(
                      //     horizontal: horizontalSize * 0.12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            provider.favouriteSentences.isNotEmpty
                                ? Container(
                                    height: verticalSize / 3,
                                    width: horizontalSize * 0.78,
                                    padding: EdgeInsets.symmetric(
                                        vertical: verticalSize * 0.05),
                                    child: Center(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: provider
                                                .favouritePicts[
                                                    provider.selectedIndexFav]
                                                .length +
                                            1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final Pict speakPict = Pict(
                                            localImg: true,
                                            id: 0,
                                            texto: Texto(),
                                            tipo: 6,
                                            imagen:
                                                Imagen(picto: "logo_ottaa_dev"),
                                          );
                                          if (provider
                                                  .favouritePicts[
                                                      provider.selectedIndexFav]
                                                  .length >
                                              index) {
                                            final Pict pict =
                                                provider.favouritePicts[provider
                                                    .selectedIndexFav][index];
                                            return Container(
                                              margin: const EdgeInsets.all(10),
                                              child: MiniPicto(
                                                localImg: pict.localImg,
                                                pict: pict,
                                                onTap: () {
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
                      provider.selectedIndexFav--;
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
                      provider.selectedIndexFav++;
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
                  await provider.speak();
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
