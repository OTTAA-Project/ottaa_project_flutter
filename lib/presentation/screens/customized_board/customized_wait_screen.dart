import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizeWaitScreen extends ConsumerWidget {
  const CustomizeWaitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 42,
                ),
                Image.asset(
                  AppImages.kBoardCustomizeWaitIcon,
                  width: 178,
                  height: 198,
                ),
                const SizedBox(
                  height: 68,
                ),
                Center(
                  child: Text(
                    "global.congrats".trl,
                    style: textTheme.button!.copyWith(
                      color: colorScheme.onBackground,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    "customize.wait.subtitle".trl,
                    style: textTheme.headline3,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
              child: PrimaryButton(
                onPressed: () {},
                text: "customize.wait.button".trl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
