import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/jumping_dots.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInButton extends ConsumerWidget {
  final SignInType type;
  final String text, logo;
  final ButtonStyle? style;
  final bool enabled;

  const SignInButton({
    super.key,
    required this.type,
    required this.text,
    required this.logo,
    this.style,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(loadingProvider);
    final auth = ref.watch(authProvider);

    final colorSchema = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      style: style ??
          ElevatedButton.styleFrom(
            fixedSize: const Size.fromHeight(48),
            backgroundColor: kWhiteColor,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            foregroundColor: Colors.grey,
          ),
      onPressed: enabled
          ? () async {
              final BuildContext localContext = context;

              final result = await auth.signIn(type);

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
                localContext.go(AppRoutes.waitingLogin);
              }
            }
          : null,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: loading
            ? [
                Expanded(
                  child: JumpingDotsProgressIndicator(
                    dotColor: colorSchema.primary,
                  ),
                ),
              ]
            : [
                Flexible(
                  flex: 1,
                  child: Image.asset(logo, height: 20),
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 2,
                  child: Text(text, style: textTheme.headline3),
                )
              ],
      ),
    );
  }
}
