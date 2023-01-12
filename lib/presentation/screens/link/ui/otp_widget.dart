import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/providers/link_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/loading_modal.dart';
import 'package:ottaa_project_flutter/presentation/screens/link/ui/token_input.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';

class OTPWidget extends ConsumerStatefulWidget {
  const OTPWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends ConsumerState<OTPWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(linkProvider);
    final size = MediaQuery.of(context).size;

    return Form(
      key: provider.codeFormKey,
      child: SizedBox(
        height: 100,
        width: size.width * 0.8,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(7, (index) {
            if (index % 2 != 0) {
              return const Spacer();
            }

            final tokenId = index ~/ 2;

            return Expanded(
              flex: 3,
              child: TokenInput(
                tokenId: tokenId,
                controller: provider.controllers[tokenId],
                node: provider.focusNodes[tokenId],
                onChanged: (_, value) async {
                  provider.tokenChanged(tokenId, value);
                  bool isCode = provider.isValidCode();
                  if (isCode) {
                    bool isValid = false;
                    await LoadingModal.show(context, future: () async {
                      isValid = await provider.validateCode() == null;
                    });

                    if (!isValid) {
                      //TODO Emir check that this is OK
                      OTTAANotification.secondary(context, text: "profile.link.token.invalid".trl);
                      return;
                    }
                    context.push(AppRoutes.linkWaitScreen);
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
