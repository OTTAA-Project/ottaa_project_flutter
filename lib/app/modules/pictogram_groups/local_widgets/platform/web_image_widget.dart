import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class WebImageWidget extends StatelessWidget {
  const WebImageWidget({
    Key? key,
    required this.isEditing,
    required this.imageName,
    this.imageWidget,
    this.selectedImageUrl,
  }) : super(key: key);
  final bool isEditing;
  final String imageName;
  final Image? imageWidget;
  final String? selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? imageWidget == null
            ? Image.network(
                selectedImageUrl == '' ? imageName : selectedImageUrl!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: kOTTAAOrangeNew,
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                    ),
                  );
                },
              )
            : imageWidget!
        : Image.network(
            selectedImageUrl == '' ? imageName : selectedImageUrl!,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: kOTTAAOrangeNew,
                  value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                ),
              );
            },
          );
  }
}
