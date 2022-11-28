import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/sentences_provider.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
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
            final Pict speakPict = Pict(
              localImg: true,
              id: 0,
              texto: Texto(),
              tipo: 6,
              imagen: Imagen(picto: "logo_ottaa_dev"),
            );
            if (provider.favouriteOrNotPicts[provider.selectedIndexFavSelection].length > index) {
              final Pict pict = provider.favouriteOrNotPicts[provider.selectedIndexFavSelection][index];
              return Container(
                margin: const EdgeInsets.all(10),
                child: MiniPicto(
                  localImg: pict.localImg,
                  pict: pict,
                  onTap: () {
                    provider.sentences[provider.selectedIndexFavSelection].favouriteOrNot = !provider.sentences[provider.selectedIndexFavSelection].favouriteOrNot;
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
                    provider.sentences[provider.selectedIndexFavSelection].favouriteOrNot = !provider.sentences[provider.selectedIndexFavSelection].favouriteOrNot;
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
