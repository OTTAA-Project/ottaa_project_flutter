import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/about_provider.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileHelpScreen extends ConsumerWidget {
  const ProfileHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final provider = ref.watch(profileProvider);
    final mailProvider = ref.read(aboutProvider);
    return ResponsiveWidget(
      child: Scaffold(
        appBar: OTTAAAppBar(
          title: Text(
            "profile.help.help".trl,
            style: textTheme.displaySmall,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionCard(
                  title: "profile.help.title1".trl,
                  subtitle: '',
                  trailingImage: const AssetImage(AppImages.kProfileHelpIcon1),
                  onPressed: () => context.push(AppRoutes.userProfileHelpFaq),
                ),
                const SizedBox(
                  height: 16,
                ),
                ActionCard(
                  title: "profile.help.title2".trl,
                  subtitle: '',
                  trailingImage: const AssetImage(AppImages.kProfileHelpIcon2),
                  onPressed: () async {
                    bool? wantsCall = await BasicBottomSheet.show(
                      context,
                      title: 'global.support'.trl,
                      children: [
                        GestureDetector(
                          onTap: () async =>
                              await mailProvider.sendSupportEmail(),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text("Mail:", style: textTheme.displaySmall),
                              const SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                child: Text(
                                  "support@ottaaproject.com",
                                  style: textTheme.displaySmall?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "¿Desea comunicarse por teléfono con soporte técnico?",
                          textAlign: TextAlign.center,
                          style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                      okButtonText: "Llamar",
                      cancelButtonText: "Cancelar",
                      cancelButtonEnabled: true,
                    );

                    if (wantsCall == true) {
                      await provider.openDialer();
                    }
                  },
                  imageSize: const Size(129, 96),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
