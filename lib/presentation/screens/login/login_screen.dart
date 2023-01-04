import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/presentation/screens/login/ui/sign_in_button.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await unblockRotation();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final maxEdge = max(size.width, size.height);

    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      top: false,
      child: Scaffold(
        body: SizedBox.fromSize(
          size: size,
          child: Stack(
            children: [
              Positioned(
                right: -maxEdge * 0.2,
                top: -maxEdge * 0.05,
                width: maxEdge / 2,
                height: maxEdge / 2,
                child: Image.asset(
                  AppImages.kOttaaTablet,
                  width: maxEdge / 2,
                  height: maxEdge / 2,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: kIsTablet ? maxEdge / 2 : maxEdge,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "login.title".trl,
                        style: textTheme.headline2,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SignInButton(
                          text: "login.google".trl,
                          logo: AppImages.kGoogleIcon,
                          type: SignInType.google,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      foregroundColor: kBlackColor),
                  child: Text(
                    "login.register".trl,
                    style: textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
