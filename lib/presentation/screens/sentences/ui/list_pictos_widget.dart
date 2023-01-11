import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/sentences_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/mini_picto_widget.dart';

class ListPictosWidget extends ConsumerWidget {
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Color? backgrounColor;

  const ListPictosWidget({super.key, this.width, this.height, this.padding, this.backgrounColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(sentencesProvider);

    if (provider.sentencesPicts.isNotEmpty) return Container();

    return Container(
      width: width,
      height: height,
      color: backgrounColor,
      padding: padding,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: provider.favouriteOrNotPicts[provider.selectedIndexFavSelection].length + 1,
          itemBuilder: (BuildContext context, int index) {
            final Picto speakPict = Picto(
              id: 0,
              type: 6,
              resource: AssetsImage(asset: "logo_ottaa_dev", network: null),
            );
            if (provider.favouriteOrNotPicts[provider.selectedIndexFavSelection].length > index) {
              final Picto pict = provider.favouriteOrNotPicts[provider.selectedIndexFavSelection][index];
              return Container(
                margin: const EdgeInsets.all(10),
                child: MiniPicto(
                  localImg: pict.resource.asset != null,
                  pict: pict,
                  onTap: () {
                    // provider.sentences[provider.selectedIndexFavSelection].favouriteOrNot = !provider.sentences[provider.selectedIndexFavSelection].favouriteOrNot;
                    //TODO: Fix this
                    provider.speakFavOrNot();
                  },
                ),
              );
            } else {
              return Container(
                margin: const EdgeInsets.all(10),
                child: MiniPicto(
                  localImg: speakPict.resource.asset != null,
                  pict: speakPict,
                  onTap: () {
                    // provider.sentences[provider.selectedIndexFavSelection].favouriteOrNot = !provider.sentences[provider.selectedIndexFavSelection].favouriteOrNot;
                    //TODO: Fix this
                    provider.speakFavOrNot();
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
