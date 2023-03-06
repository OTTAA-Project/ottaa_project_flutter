import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/sentences_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_logo_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/ui/list_pictos_widget.dart';

class SentencesScreen extends ConsumerStatefulWidget {
  const SentencesScreen({Key? key}) : super(key: key);

  // @override
  // State<SentencesPage> createState() => _SentencesPageState();
  @override
  ConsumerState<SentencesScreen> createState() => _SentencesPageState();
}

class _SentencesPageState extends ConsumerState<SentencesScreen> {
  @override
  void initState() {
    super.initState();

    final provider = ref.read(sentencesProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.inIt();
    });
  }

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    // final provider = ref.watch(sentencesProvider);

    final speak = ref.read(sentencesProvider.select((prov) => prov.speak));

    final showCircular = ref.watch(sentencesProvider.select((prov) => prov.showCircular));

    var sentencesIndex = ref.read(sentencesProvider.select((prov) => prov.sentencesIndex));
    final changeSentencesIndex = ref.read(sentencesProvider.select((prov) => prov.changeSelectedIndexFav));

    final fetchFavourites = ref.read(sentencesProvider.select((prov) => prov.fetchFavourites));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('most_used_sentences'.trl),
        actions: [
          GestureDetector(
            onTap: () {
              fetchFavourites();
              context.push(AppRoutes.favouriteSentences);
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
                              context.push(AppRoutes.searchSentences);
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
                padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.099),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
                  child: Center(
                    child: FadeInDown(
                      controller: (controller) => ref.read(sentencesProvider.select((prov) => prov.setAnimationController))(controller),
                      from: 30,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListPictosWidget(
                              height: verticalSize / 3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
                      changeSentencesIndex(sentencesIndex--);
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
                      changeSentencesIndex(sentencesIndex++);
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
