import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/loading_modal.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/column_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_logo_widget.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/pictogram_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/home_drawer.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/word_bar.dart';
import 'package:picto_widget/picto_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    final provider = ref.read(homeProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      blockLandscapeMode();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      setState(() {});
      // await LoadingModal.show(context, future: provider.init);
    });
  }

  @override
  void dispose() {
    unblockRotation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false; //TODO: Ask for pop :)
      },
      child: Scaffold(
        body: SizedBox.fromSize(
          size: size,
          child: Flex(
            direction: Axis.vertical,
            children: [
              const SizedBox(height: 20),
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: SizedBox(
                  width: size.width,
                  height: 80,
                  child: const WordBarUI(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
