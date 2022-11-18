import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/sentences_provider.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/column_widget.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_logo_widget.dart';

class SearchSentenceScreen extends ConsumerWidget {
  const SearchSentenceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    final provider = ref.watch(sentencesProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        leading: Container(),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('all_phrases'.trl),
        actions: [
          Container(
            padding: EdgeInsets.only(right: horizontalSize * 0.04),
            width: horizontalSize * 0.3,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: provider.searchController,
                    decoration: InputDecoration(
                      hintText: '${'search'.trl}...',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (v) {
                      provider.onChangedText(v);
                    },
                  ),
                ),
                SizedBox(
                  width: horizontalSize * 0.02,
                ),
                GestureDetector(
                  onTap: () => provider.searchOrIcon = false,
                  child: const Icon(
                    Icons.clear,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * .10),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalSize * 0.02,
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              provider.sentencesForList.isNotEmpty
                                  ? Container(
                                      height: verticalSize / 3,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: provider
                                                .sentencesPicts[provider
                                                    .sentencesForList[
                                                        provider.searchIndex]
                                                    .index]
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
                                                  .sentencesPicts[provider
                                                      .sentencesForList[
                                                          provider.searchIndex]
                                                      .index]
                                                  .length >
                                              index) {
                                            final Pict pict =
                                                provider.sentencesPicts[provider
                                                    .sentencesForList[
                                                        provider.searchIndex]
                                                    .index][index];
                                            return Container(
                                              margin: const EdgeInsets.all(10),
                                              child: MiniPicto(
                                                localImg: pict.localImg,
                                                pict: pict,
                                                onTap: () {
                                                  provider.searchSpeak();
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
                                                    provider.searchSpeak();
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'please_enter_a_valid_search'.trl,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                          Container(),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ColumnWidget(
              columnType: ColumnType.left,
              children: [
                GestureDetector(
                  onTap: provider.decrementOne,
                  child: Icon(
                    Icons.skip_previous,
                    size: verticalSize * 0.1,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            /* Positioned(
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
                    onTap: controller.decrementOne,
                    child: Icon(
                      Icons.skip_previous,
                      size: verticalSize * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),*/
            ColumnWidget(
              columnType: ColumnType.right,
              children: [
                GestureDetector(
                  onTap: provider.incrementOne,
                  child: Icon(
                    Icons.skip_next,
                    size: verticalSize * 0.1,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            OttaaLogoWidget(
              onTap: () async {
                await provider.searchSpeak();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
