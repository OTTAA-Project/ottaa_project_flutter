import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/application/providers/view_board_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';

class SearchDataScreen extends ConsumerWidget {
  const SearchDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(viewBoardProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: OTTAAAppBar(
        title: Text(
          '${'game.search'.trl} / ${'global.pictogram'.trl}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length >= 3) {
                        //todo: search and show the pictos and boards
                        provider.searchForMatchingData(text: value);
                      }
                      if (value.isEmpty) {
                        provider.isSearching = false;
                        provider.notify();
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () async {},
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'global.search'.trl,
                    ),
                  ),
                ),
                provider.isSearching
                    ? provider.isDataFetched
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'home.grid.title'.trl,
                                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              ListView.builder(
                                itemCount: provider.filteredBoards.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 16),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: PictogramCard(
                                      title: provider.filteredBoards[index].text,
                                      actionText: "customize.board.subtitle".trl,
                                      pictogram: CachedNetworkImageProvider(
                                        provider.filteredBoards[index].resource.network!,
                                      ),
                                      status: !provider.filteredBoards[index].block,
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) => const Center(
                                                  child: CircularProgressIndicator(),
                                                ));
                                        final pro = ref.read(createPictoProvider);
                                        await pro.init(userId: provider.userID);
                                        int i = -1;
                                        final res = provider.boards.firstWhere((element) {
                                          i++;
                                          return element.id == provider.filteredBoards[index].id;
                                        });
                                        await pro.setForBoardEdit(index: i);
                                        context.pop();
                                        context.push(AppRoutes.patientCreateBoard);
                                      },
                                      onChange: (bool a) {},
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'global.pictogram'.trl,
                                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              GridView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                itemCount: provider.filteredSearchPictos.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemBuilder: (context, index) {
                                  return FittedBox(
                                    fit: BoxFit.contain,
                                    child: PictoWidget(
                                      onTap: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) => const Center(
                                                  child: CircularProgressIndicator(),
                                                ));
                                        final pro = ref.read(createPictoProvider);
                                        await pro.init(userId: provider.userID);
                                        await pro.setForPictoEdit(pict: provider.filteredSearchPictos[index]);
                                        context.pop();
                                        context.push(AppRoutes.patientEditPicto);
                                      },
                                      imageUrl: provider.filteredSearchPictos[index].resource.network,
                                      text: provider.filteredSearchPictos[index].text,
                                      colorNumber: provider.filteredSearchPictos[index].type,
                                      disable: provider.filteredSearchPictos[index].block,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          )
                        : const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                    : Padding(
                        padding: const EdgeInsets.only(top: 64),
                        child: Image.asset(
                          AppImages.kSearchPhoto,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
