import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class LinkSuccessScreen extends ConsumerStatefulWidget {
  const LinkSuccessScreen({super.key});

  @override
  ConsumerState<LinkSuccessScreen> createState() => _LinkSuccessScreenState();
}

class _LinkSuccessScreenState extends ConsumerState<LinkSuccessScreen> {
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text("profile.link.success.title".trl, style: textTheme.headline2),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 312,
              child: ProfileCard(
                title: "Juan Varela",
                subtitle: "link.success.lastTime".trlf({"date": "33:33 PM"}), //TODO: Re do this u.u
                leadingImage: const AssetImage("assets/profiles/Group 673@2x.png"),
                actions: IconButton(
                  onPressed: () {},
                  color: kBlackColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: kBlackColor,
                  ),
                  style: IconButton.styleFrom(
                    foregroundColor: kBlackColor,
                  ),
                  splashRadius: 10,
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: size.width * 0.8,
            child: PrimaryButton(
              onPressed: () => context.push(AppRoutes.customizedBoardScreen),
              text: "global.continue".trl,
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
