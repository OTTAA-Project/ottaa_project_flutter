import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/right_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/actions_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/left_column_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/sentence_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/local_widgets/suggested_widget.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
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
                            SizedBox(width: 15),
                            ClipRRect(
                              child: Image(
                                image: AssetImage('assets/Group 671.png'),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                _.voiceText.toUpperCase(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        width: horizontalSize * 0.35,
                        height: verticalSize * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    );
                  return Container();
                },
              ),
              // if (_.isPlaying())
            ],
          ),
          backgroundColor: Colors.black,
        );
      },
    );
  }
}
