import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/left_column_widget.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/right_column_widget.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double height = size.height;
    final double width = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.bottomLeft,
            child: LeftColumnWidget(),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: RightColumnWidget(),
          ),
          Column(
            //MAIN COLUMN
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Padding(
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
                      const SizedBox(width: 10),
                      Container(),
                      const SizedBox(width: 10),
                      Padding(
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
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            left: width / 3,
            right: width / 3,
            bottom: height * 0.045,
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
              onPressed: () {
                //TODO: Add tts function
                context.go(AppRoutes.tutorial);
              },
              child: SizedBox(
                height: height * 0.16,
                width: height * 0.16,
                child: Center(
                  child: Image.asset(
                    AppImages.kIconoOttaa,
                    color: Colors.white,
                    height: height * 0.05,
                    width: width * 0.05,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
