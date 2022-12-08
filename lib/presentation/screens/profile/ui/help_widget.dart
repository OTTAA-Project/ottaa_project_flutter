import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class HelpWidget extends StatelessWidget {
  const HelpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: kOTTAABackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text('Soporte'),
            const SizedBox(
              height: 24,
            ),
            Text.rich(
              TextSpan(
                text: 'Mail:',
                children: [
                  TextSpan(
                    text: 'Support@ottaaproject.com',
                    style: TextStyle(
                        //todo: make it underline
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //todo: take to the email app from here ask hector about the info fo rit
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24 * 2,
            ),
            Text(
              "profile.help.heading".trl,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: 'profile.help.button1'.trl,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {},
                    text: 'profile.help.button2'.trl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
