import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  if (value.length >= 3) {
                    //todo: search and show the pictos and boards
                    provider.searchForMatchingData(text: value);
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
              provider.isDataFetched
                  ? Expanded(
                      child: Column(
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
                                  onPressed: () async {},
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
                            shrinkWrap: true,
                            itemCount: provider.filteredPictos.length,
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
                                    final pro = ref.read(createPictoProvider);
                                    await pro.setForPictoEdit(pict: provider.filteredPictos[index]);
                                    context.push(AppRoutes.patientEditPicto);
                                  },
                                  imageUrl: provider.filteredPictos[index].resource.network,
                                  text: provider.filteredPictos[index].text,
                                  colorNumber: provider.filteredPictos[index].type,
                                  disable: provider.filteredPictos[index].block,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
