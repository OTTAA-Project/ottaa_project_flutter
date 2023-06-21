import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:picto_widget/picto_widget.dart';

class ImageWidget extends ConsumerWidget {
  const ImageWidget({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: size.height * 0.2,
        height: size.height * 0.25,
        child: FittedBox(
          fit: BoxFit.fill,
          child: PictoWidget(
            colorNumber: provider.borderColor,
            image: provider.isImageSelected
                ? provider.imageUrlForPicto.isNotEmpty
                    ? Image.network(provider.imageUrlForPicto)
                    : Image.file(File(provider.imageForPicto.path))
                : Image.asset(AppImages.kAddIcon),
            onTap: onTap,
            text: provider.nameController.text.isEmpty ? 'global.add'.trl : provider.nameController.text,
          ),
        ),
      ),
    );
  }
}
