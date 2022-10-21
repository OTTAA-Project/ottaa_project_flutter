import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/jumping_dots.dart';
import 'package:ottaa_project_flutter/presentation/screens/login/ui/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final maxEdge = max(size.width, size.height);

    return Scaffold(
      backgroundColor: const Color(0xffececec),
      extendBody: true,
      body: SizedBox.fromSize(
        size: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: maxEdge * 0.4,
              child: Image.asset(
                AppImages.kLogoOttaa,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: maxEdge * 0.2),
              child: Text(
                'login_screen'.trl,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: maxEdge * 0.4,
              child: SignInButton(
                type: SignInType.google,
                text: "Login_with_google".trl,
                logo: AppImages.kGoogleIcon,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: maxEdge * 0.4,
              child: SignInButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kFacebookColor,
                  fixedSize: const Size.fromHeight(50),
                ),
                type: SignInType.facebook,
                text: "Login_with_facebook".trl,
                logo: AppImages.kFacebookIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
