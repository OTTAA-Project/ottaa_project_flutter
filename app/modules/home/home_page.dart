import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/right_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/actions_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/left_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/sentence_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/suggested_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(
        id: "home",
        builder: (_) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  //MAIN COLUMN
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // TOP ROW
                    SentenceWidget(),
                    Row(
                      // BODY ROW
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // LEFT COLUMN
                        LeftColumnWidget(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // BODY
                            SuggestedWidget(),
                            ActionsWidget(),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        // RIGHT COLUMN
                        RightColumnWidget(),
                      ],
                    )
                    //SizedBox(height: 10),
                  ],
                ),
                GetBuilder<HomeController>(
                    id: "subtitle",
                    builder: (_) {
                      if (_.hasText())
                        return Center(
                          child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10),
                                    child: ClipRRect(
                                      child: Image(
                                          image: AssetImage(
                                              'assets/Group 671.png')),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        _.ttsController.isSubtitleUppercase
                                            ? _.voiceText.toUpperCase()
                                            : _.voiceText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30 +
                                                7.5 *
                                                    _.ttsController
                                                        .subtitleSize)),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                              width: horizontalSize * 0.35,
                              // height: verticalSize * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(100))),
                        );
                      return Container();
                    }),
                // if (_.isPlaying())
              ],
            ),
            backgroundColor: Colors.black,
          );
        });
  }
}
