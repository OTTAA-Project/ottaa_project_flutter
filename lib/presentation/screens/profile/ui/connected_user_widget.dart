import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_user_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ConnectedUserWidget extends StatelessWidget {
  const ConnectedUserWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.image,
    required this.actionTap,
    required this.timeText,
    required this.show,
    required this.settingsTap,
  }) : super(key: key);

  final String title, image, timeText;
  final void Function()? onPressed, actionTap, settingsTap;
  final bool show;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background,
      ),
      child: Column(
        children: [
          ProfileCard(
            title: title,
            leadingImage: CachedNetworkImageProvider(
              image,
              // provider.connectedUsersProfileData[index].imageUrl,
            ),
            onPressed: onPressed,
            subtitle: timeText,
            actions: GestureDetector(
              onTap: actionTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    show
                        ? 'profile.close_profile'.trl
                        : 'profile.open_profile'.trl,
                    style: textTheme.subtitle1,
                  ),
                  Icon(
                    show
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: show ? 362 : 0,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileUserWidget(
                          title:
                              "${'profile.tips.title2'.trl} / ${'global.pictogram'.trl}",
                          onTap: () {},
                        ),
                        ProfileUserWidget(
                          title: 'profile.tips.title1'.trl,
                          onTap: () {},
                        ),
                        ProfileUserWidget(
                          title: 'global.configuration'.trl,
                          onTap: settingsTap,
                        ),
                        ProfileUserWidget(
                          title: 'profile.profile'.trl,
                          onTap: () {},
                        ),
                        ProfileUserWidget(
                          title: 'profile.help.help'.trl,
                          onTap: () =>
                              context.push(AppRoutes.profileHelpScreen),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        PrimaryButton(
                          text: 'global.user_ottaa'.trlf({'name': title}),
                          onPressed: () {},
                          enabled: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
