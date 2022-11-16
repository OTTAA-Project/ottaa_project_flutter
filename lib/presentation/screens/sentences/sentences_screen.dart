import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_logo_widget.dart';


class SentencesPage extends StatelessWidget {
  const SentencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('most_used_sentences'.trl),
        actions: [
          GestureDetector(
            onTap: () async {
              //todo: go to the route and fetch the favorites
              await _.fetchFavourites();
              // Get.toNamed(AppRoutes.FAVOURITESCREENPAGE);
            },
            child: const Icon(Icons.star),
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
                            //todo: back to the previous screen
                            onTap: () {
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
                              //todo: go to the search sentence screen
                              // Get.to(SearchSentence());
                            },
                            child: Icon(
                              Icons.search,
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
                    //todo: add the required update into it
                    child: FadeInDown(
                      controller: (controller) =>
                      _.sentenceAnimationController = controller,
                      from: 30,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _.sentencesPicts.isNotEmpty
                                ? Container(
                              height: verticalSize / 3,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                _.sentencesPicts[_.sentencesIndex]
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
                                  if (_.sentencesPicts[_.sentencesIndex]
                                      .length >
                                      index) {
                                    final Pict pict = _.sentencesPicts[
                                    _.sentencesIndex][index];
                                    return Container(
                                      margin: const EdgeInsets.all(10),
                                      child: MiniPicto(
                                        localImg: pict.localImg,
                                        pict: pict,
                                        onTap: () {
                                          _.speak();
                                        },
                                      ),
                                    );
                                  } else {
                                    return Bounce(
                                      from: 6,
                                      infinite: true,
                                      child: Container(
                                        margin:
                                        const EdgeInsets.all(10),
                                        child: MiniPicto(
                                          localImg: speakPict.localImg,
                                          pict: speakPict,
                                          onTap: () {
                                            _.speak();
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                },
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
            controller.showCircular.value
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
                      controller.sentencesIndex--;
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
                      controller.sentencesIndex++;
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
                  await controller.speak();
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
