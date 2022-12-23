import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/extensions/validator_string.dart';
import 'package:ottaa_project_flutter/application/providers/link_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class LinkMailScreen extends ConsumerStatefulWidget {
  const LinkMailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinkMailScreenState();
}

class _LinkMailScreenState extends ConsumerState<LinkMailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = ref.watch(linkProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text("global.back".trl),
      ),
      body: Center(
        child: SizedBox(
          width: size.width * 0.8,
          height: size.height,
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "profile.link.mail.title".trl,
                textAlign: TextAlign.center,
                style: textTheme.headline2,
              ),
              const SizedBox(height: 24),
              Form(
                key: provider.formKey,
                child: OTTAATextInput(
                  labelText: "global.email".trl,
                  keyboardType: TextInputType.emailAddress,
                  controller: provider.emailController,
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return "profile.link.mail.input.required".trl;
                    }

                    if (value != null && !value.isEmail) {
                      return "profile.link.mail.input.invalid".trl;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "profile.link.mail.contact",
                textAlign: TextAlign.center,
                style: textTheme.bodyText2,
              ),
              const SizedBox(height: 16),
              Text(
                "profile.link.mail.warn",
                textAlign: TextAlign.center,
                style: textTheme.bodyText2,
              ),
              const Spacer(),
              OptionalButton(
                text: "global.send",
                onPressed: () {
                  if (provider.formKey.currentState!.validate()) {
                    //TODO:
                    // 1. Send email to provider.emailController.text
                    // 2. Navigate to LinkTokeScreen
                    context.push(AppRoutes.linkTokenScreen);
                  }
                },
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
