import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/screen_helpers.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/core/enums/home_screen_status.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/home_grid.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/home_tabs.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/pictos_bar.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_mobile.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/widgets/home_tablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

      //We are using size.height because at this time the screen is not rotated
      int pictoCount = 4;

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
          fit: FlexFit.tight,
          flex: 2,
          child: SizedBox(
            width: size.width,
            child: const PictosBarUI(),
          ),
        );
      case HomeScreenStatus.grid:
        return const Expanded(
          flex: 2,
          child: HomeGridUI(),
        );
      case HomeScreenStatus.tabs:
        return const Expanded(
          flex: 2,
          child: HomeTabsUI(),
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
        return false;
      },
      child: Scaffold(
        body: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            switch (sizingInformation.deviceScreenType) {
              case DeviceScreenType.desktop:
              case DeviceScreenType.tablet:
                return HomeTabletLayout(
                  child: currentHomeStatus(provider.status),
                );
              default:
                return HomeMobileLayout(
                  child: currentHomeStatus(provider.status),
                );
            }
          },
        ),
      ),
    );
  }
}
