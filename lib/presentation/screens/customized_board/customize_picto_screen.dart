import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/ui/board_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';

class CustomizePictoScreen extends ConsumerStatefulWidget {
  const CustomizePictoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomizePictoScreen> createState() =>
      _CustomizePictoScreenState();
}

class _CustomizePictoScreenState extends ConsumerState<CustomizePictoScreen> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final provider = ref.watch(customiseProvider);
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Row(
          children: [
            Text(
              "customize.picto.title"
                  .trlf({"name": provider.selectedGroupName}),
              style: textTheme.headline3,
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
        actions: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Text(
              "global.skip".trl,
              style:
                  textTheme.headline4!.copyWith(color: colorScheme.onSurface),
            ),
          ),
        ],
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
                  title: "customize.picto.title"
                      .trlf({"name": provider.selectedGroupName}),
                  //todo: this one is a placeholder for now
                  image:
                      CachedNetworkImageProvider(provider.selectedGroupImage),
                  customizeOnTap: () {
                    print('customize on tap');
                  },
                  deleteOnTap: () {
                    print('delete on tap');
                  },
                  onChanged: (bool a) {
                    provider.groups[provider.selectedGroup].blocked = !a;
                    provider.selectedGroupStatus = !a;
                    provider.notify();
                  },
                  status: !provider.selectedGroupStatus,
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
              itemCount: provider.selectedGruposPicts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 130,
              ),
              itemBuilder: (context, index) => PictoWidget(
                onTap: () {
                  provider.block(index: index);
                },
                imageUrl: provider.selectedGruposPicts[index].imagen.picto,
                text: provider.selectedGruposPicts[index].texto.es,
                colorNumber: provider.selectedGruposPicts[index].tipo,
                disable: provider.selectedGruposPicts[index].blocked!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
