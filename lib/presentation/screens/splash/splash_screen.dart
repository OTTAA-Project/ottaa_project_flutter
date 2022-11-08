import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/repositories/splash_repository.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(splashProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/imgs/logo_ottaa.webp'),
          ),
          const LinearProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.deepOrange,
          ),
          const SizedBox(height: 10),
          Text("we_are_preparing_everything".trl)
        ],
      ),
    );
  }
}
