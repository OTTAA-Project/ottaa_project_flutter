import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class ProfileWaitingScreen extends StatefulWidget {
  const ProfileWaitingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileWaitingScreen> createState() => _ProfileWaitingScreenState();
}

class _ProfileWaitingScreenState extends State<ProfileWaitingScreen> {
  @override
  void initState() {
    super.initState();
    //todo: or we can use this callback
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        const Duration(seconds: 2),
        () => context.push(AppRoutes.profileMainScreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //todo: can be converted to a dialouge and used with showDialouge

    return Scaffold(
      backgroundColor: kOTTAABackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "profile.aguarde".trl,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "profile.configurando.su.experiencia".trl,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
