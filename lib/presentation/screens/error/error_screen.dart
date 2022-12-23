import 'package:flutter/material.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox.fromSize(
        size: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿Whot 😀?'),
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: "Go back",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
