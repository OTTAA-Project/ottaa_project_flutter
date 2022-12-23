import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/link_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/link/ui/otp_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/link/ui/token_input.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class LinkTokenScreen extends ConsumerStatefulWidget {
  const LinkTokenScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinkTokenScreenState();
}

class _LinkTokenScreenState extends ConsumerState<LinkTokenScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final reset = ref.read(linkProvider.select((value) => value.reset));
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
                "profile.link.token.title".trl,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 24),
              const OTPWidget(),
              const Spacer(),
              Text(
                "profile.link.token.problem".trl,
                style: textTheme.bodyText2,
              ),
              const SizedBox(height: 16),
              SecondaryButton(
                onPressed: () {},
                text: "profile.link.token.resend".trl,
              ),
              const SizedBox(height: 16),
              SecondaryButton(
                onPressed: () {
                  reset();
                  Navigator.of(context).pop();
                },
                text: "profile.link.token.back".trl,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
