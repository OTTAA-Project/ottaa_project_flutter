import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class LinkSuccessScreen extends StatelessWidget {
  const LinkSuccessScreen({super.key});

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
          Text("profile.link.success.title", style: textTheme.headline2),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 312,
              child: ProfileCard(
                title: "Juan Varela",
                subtitle: "Últ. vez Ayer 24:23",//TODO: Re do this u.u
                leadingImage: AssetImage("assets/profiles/Group 673@2x.png"),
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
              onPressed: ()  => context.push(AppRoutes.customizedBoardScreen),
              text: "global.continue",
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
