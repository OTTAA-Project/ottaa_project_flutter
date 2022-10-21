import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/jumping_dots.dart';

class SignInButton extends ConsumerWidget {
  final SignInType type;
  final String text, logo;
  final ButtonStyle? style;

  const SignInButton({super.key, required this.type, required this.text, required this.logo, this.style});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(loadingProvider);
    final auth = ref.watch(authProvider);

    return ElevatedButton(
      style: style ??
          ElevatedButton.styleFrom(
            fixedSize: const Size.fromHeight(50),
          ),
      onPressed: () async {
        Either<String, User> result = await auth.signIn(type);

        if (result.isLeft) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.left),
            ),
          );
        }
      },
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: loading
            ? [
                const Expanded(
                  child: JumpingDotsProgressIndicator(),
                ),
              ]
            : [
                Expanded(
                  flex: 1,
                  child: Image.asset(logo, height: 20),
                ),
                Expanded(
                  flex: 2,
                  child: Text(text),
                )
              ],
      ),
    );
  }
}
