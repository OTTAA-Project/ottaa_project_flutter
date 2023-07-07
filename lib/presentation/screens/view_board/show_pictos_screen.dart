import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/application/providers/view_board_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/ui/board_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';

class ShowPictosScreen extends ConsumerWidget {
  const ShowPictosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final provider = ref.watch(viewBoardProvider);
    return ResponsiveWidget(
      child: Scaffold(
        appBar: OTTAAAppBar(
          title: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  provider.boards[provider.selectedBoardID].text,
                  style: textTheme.headline3,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.help_outline_rounded,
                  size: 24,
                ),
                onPressed: () => BasicBottomSheet.show(
                  context,
                  // title: "",
                  subtitle: "board.customize.helpText".trl,
                  children: <Widget>[
                    Image.asset(
                      AppImages.kBoardImageEdit1,
                      height: 166,
                    ),
                  ],
                  okButtonText: "board.customize.okText".trl,
                ),
                padding: const EdgeInsets.all(0),
                color: colorScheme.onSurface,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  BoardWidget(
                    title: provider.boards[provider.selectedBoardID].text.toUpperCase(),
                    image: CachedNetworkImageProvider(provider.boards[provider.selectedBoardID].resource.network!),
                    customizeOnTap: () async {
                      showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
                      final pro = ref.read(createPictoProvider);
                      await pro.init(userId: provider.userID);
                      await pro.setForBoardEdit(index: provider.selectedBoardID);
                      context.pop();
                      context.push(AppRoutes.patientCreateBoard);
                    },
                    deleteOnTap: () async {
                      showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
                      await provider.deleteBoard();
                      context.pop();
                      context.pop();
                      provider.notify();
                    },
                    onChanged: (bool a) {
                      provider.boards[provider.selectedBoardID].block = !a;
                      provider.notify();
                    },
                    status: !provider.boards[provider.selectedBoardID].block,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                itemCount: provider.filteredPictos.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  if (provider.filteredPictos.length == index) {
                    return FittedBox(
                      fit: BoxFit.contain,
                      child: PictoWidget(
                        onTap: () async {
                          final pro = ref.read(createPictoProvider);
                          await pro.init(userId: provider.userID);
                          context.push(AppRoutes.patientCreatePicto);
                        },
                        image: Image.asset(
                          AppImages.kAddIcon,
                        ),
                        text: 'global.add'.trl,
                      ),
                    );
                  }
                  return FittedBox(
                    fit: BoxFit.contain,
                    child: PictoWidget(
                      onTap: () {
                        provider.filteredPictos[index].block = !provider.filteredPictos[index].block;
                        provider.notify();
                      },
                      imageUrl: provider.filteredPictos[index].resource.network,
                      text: provider.filteredPictos[index].text,
                      colorNumber: provider.filteredPictos[index].type,
                      disable: provider.filteredPictos[index].block,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
