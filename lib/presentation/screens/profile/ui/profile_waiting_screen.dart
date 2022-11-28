import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';

class ProfileWaitingScreen extends StatelessWidget {
  const ProfileWaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "profile.aguarde".trl,
            ),
          ),
          Text(
            'Configurando su experiencia...',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
