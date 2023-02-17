import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/screen_util.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/enums/home_screen_status.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/actions_bar.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/groups_home.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/pictos_bar.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/talk_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/word_bar.dart';

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

      final size = MediaQuery.of(context).size;
      int pictoSize = 116;

      //We are using size.height because at this time the screen is not rotated
      int pictoCount = kIsTablet ? 6 : 4;

      final setSuggested = ref.read(homeProvider.select((value) => value.setSuggedtedQuantity));

      setSuggested(pictoCount);

      await ref.read(homeProvider.select((value) => value.init))();
      setState(() {});
    });
  }

  @override
  void dispose() {
    unblockRotation();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    super.dispose();
  }

  Widget currentHomeStatus(HomeScreenStatus status) {
    final Size size = MediaQuery.of(context).size;

    switch (status) {
      case HomeScreenStatus.pictos:
        return Flexible(
          fit: FlexFit.loose,
          flex: 2,
          child: SizedBox(
            width: size.width,
            height: 312,
            child: const PictosBarUI(),
          ),
        );
      case HomeScreenStatus.search:
        return const Expanded(
          flex: 2,
          child: GroupsHomeUi(),
        );
      case HomeScreenStatus.favorites:

      case HomeScreenStatus.history:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final provider = ref.watch(homeProvider);

    return WillPopScope(
      onWillPop: () async {
        return true; //TODO: Ask for pop :)
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
                  SizedBox(
                    width: size.width,
                    height: 111,
                    // child: const WordBarUI(),
                  ),
                  currentHomeStatus(provider.status),
                ],
              ),
            ),
            const Positioned(
              top: 20,
              child: WordBarUI(),
            ),
            if (provider.show) ...[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
              ),
              const Positioned(
                top: 20,
                child: TalkWidget(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
