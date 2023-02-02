import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/actions_bar.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/pictos_bar.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/talk_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/word_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      blockLandscapeMode();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      setState(() {});
    });
  }

  @override
  void dispose() {
    unblockRotation();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final provider = ref.watch(homeProvider);

    return WillPopScope(
      onWillPop: () async {
        return false; //TODO: Ask for pop :)
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox.fromSize(
              size: size,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  const SizedBox(height: 11),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 2,
                    child: SizedBox(
                      width: size.width,
                      height: 212,
                      child: const PictosBarUI(),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: SizedBox(
                      width: size.width,
                      height: 88,
                      child: const ActionsBarUI(),
                    ),
                  ),
                ],
              ),
            ),
            if (provider.show) ...[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
              ),
              Positioned(
                top: 26,
                child: const TalkWidget(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
