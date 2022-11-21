import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/loading_modal.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/column_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_logo_widget.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/pictogram_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/ui/home_drawer.dart';
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
      await LoadingModal.show(context, future: provider.init);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double height = size.height;
    final double width = size.width;

    final provider = ref.watch(homeProvider);

    print(provider.suggestedPicts);

    return Scaffold(
      backgroundColor: Colors.black,
      drawerEdgeDragWidth: 200,
      extendBody: true,
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx.abs() > 0) {
            //TODO!: WORK FOR ASIM :) (build context: asim told he can do that better than me)
            //Another work for asim translate this: papi chulo :(
            _scaffoldKey.currentState?.openDrawer();
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: ColumnWidget(
                columnType: ColumnType.left,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {},
                      child: Center(
                        child: Icon(
                          Icons.videogame_asset,
                          color: Colors.white,
                          size: height / 12,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {},
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: height / 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ColumnWidget(
                columnType: ColumnType.right,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {},
                      child: Center(
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                          size: height / 12,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        context.push(AppRoutes.sentences);
                      },
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: height / 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Container(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: width * 0.8,
                    color: kOTTAAOrangeNew,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.045),
                            child: SizedBox(
                              width: width / 4,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.menu_sharp,
                                    color: Colors.white,
                                    size: height / 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.045),
                            child: SizedBox(
                              width: width / 4,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.backspace_rounded,
                                    color: Colors.white,
                                    size: height / 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: height * 0.16,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.099),
                child: Container(
                  height: height * 0.58,
                  width: width * 0.78,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: provider.suggestedPicts.isNotEmpty
                        ? provider.suggestedPicts
                            .sublist(0, 4)
                            .map(
                              (picto) => PictogramWidget(
                                  pictogam: picto, onTap: () {}),
                            )
                            .toList()
                        : [],
                  ),
                ),
              ),
            ),
            /* Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.045),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: kOTTAAOrangeNew,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 4,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    height: height * 0.16,
                    width: height * 0.16,
                    child: Center(
                      child: Image.asset(
                        AppImages.kIconoOttaa,
                        color: Colors.white,
                        height: height * 0.1,
                        width: width * 0.1,
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
            OttaaLogoWidget(
              onTap: () {
                //TODO: Add tts function
                context.push(AppRoutes.tutorial);
              },
            ),
          ],
        ),
      ),
    );
  }
}
