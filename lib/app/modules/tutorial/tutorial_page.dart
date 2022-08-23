import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/tutorial/local_widgets/tutorials_widgets.dart';
import 'package:ottaa_project_flutter/app/modules/tutorial/tutorial_controller.dart';


class TutorialPage extends StatelessWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return GetBuilder<TutorialController>(
      id: "tutorial",
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: PageView(
              /// [PageView.scrollDirection] defaults to [Axis.horizontal].
              /// Use [Axis.vertical] to scroll vertically.
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: <Widget>[
                step1Tutorial(controller, context),
                step2Tutorial(controller, context),
                step3Tutorial(controller, context),
                step4Tutorial(controller, context),
              ],
            ),
          ),
        );
      },
    );
  }
}
