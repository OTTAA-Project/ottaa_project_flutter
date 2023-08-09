import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class SpeakButton extends StatelessWidget {
  const SpeakButton({Key? key, required this.onTap}) : super(key: key);
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      right: 48,
      top: 24,
      child: SizedBox(
        width: 84,
        height: 80,
        child: BaseButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(colorScheme.primary),
            overlayColor:
                MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)),
              ),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: onTap,
          child: Image.asset(
            AppImages.kOttaaMinimalist,
            color: Colors.white,
            width: 59,
            height: 59,
          ),
        ),
      ),
    );
  }
}
