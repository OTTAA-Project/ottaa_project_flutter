import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignButton extends ConsumerWidget {
  const AppleSignButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SignInWithAppleButton(
        text: "login.apple".trl,
        style: SignInWithAppleButtonStyle.whiteOutlined,
        onPressed: () async {
          final BuildContext localContext = context;
          final auth = ref.watch(authProvider);
          final result = await auth.signIn(SignInType.apple);

          if (result.isLeft) {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result.left),
              ),
            );
          }

          if (result.isRight) {
            // ignore: use_build_context_synchronously
            await BasicBottomSheet.show(
              localContext,
              children: [
                GestureDetector(
                  onTap: () async {
                    await launchUrl(
                      mode: LaunchMode.externalApplication,
                      Uri.parse("https://ottaa-project.github.io/docs/Community/privacypolicy/"),
                    );
                  },
                  child: Text(
                    "terms.text".trl,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText2!,
                  ),
                )
              ],
              okButtonText: "terms.button".trl,
            );

            // ignore: use_build_context_synchronously
            localContext.go(AppRoutes.loginWait);
          }
        },
      ),
    );
  }
}
