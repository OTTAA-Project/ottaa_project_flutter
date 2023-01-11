import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/sentences_provider.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_logo_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/ui/list_pictos_widget.dart';

class AddOrRemoveFavouriteScreen extends ConsumerWidget {
  const AddOrRemoveFavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    // final provider = ref.read(sentencesProvider);
    final speak = ref.read(sentencesProvider.select((prov) => prov.speakFavOrNot));
    final showCircular = ref.watch(sentencesProvider.select((prov) => prov.showCircular));

    var selectedIndexFavSelection = ref.read(sentencesProvider.select((prov) => prov.selectedIndexFavSelection));
    final changeSentencesIndex = ref.read(sentencesProvider.select((prov) => prov.changeSelectedIndexFavSelection));

    final saveFavourite = ref.read(sentencesProvider.select((prov) => prov.saveFavourite));

    final favouriteOrNotPicts = ref.read(sentencesProvider.select((prov) => prov.favouriteOrNotPicts));

    final sentences = ref.read(sentencesProvider.select((prov) => prov.sentences));

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
              context.pop();
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
                            await saveFavourite();
                            context.pop();
                            context.pop();
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
                padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      favouriteOrNotPicts.isNotEmpty
                          ? ListPictosWidget(
                              height: verticalSize / 2.5,
                              width: horizontalSize * 0.78,
                              // backgrounColor: sentences[selectedIndexFavSelection].favouriteOrNot ? Colors.blue : Colors.transparent, TODO: Change this to uncomment code :/
                              padding: EdgeInsets.symmetric(vertical: verticalSize * 0.05),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),

            ///circularProgressIndicator
            showCircular
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
                      changeSentencesIndex(selectedIndexFavSelection--);
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
                      changeSentencesIndex(selectedIndexFavSelection++);
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
                  await speak();
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
