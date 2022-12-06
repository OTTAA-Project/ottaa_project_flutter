import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/presentation/screens/tutorial/ui/first_step.dart';
import 'package:ottaa_project_flutter/presentation/screens/tutorial/ui/fourth_step.dart';
import 'package:ottaa_project_flutter/presentation/screens/tutorial/ui/second_step.dart';
import 'package:ottaa_project_flutter/presentation/screens/tutorial/ui/third_step.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: <Widget>[
            FirstStep(controller: controller),
            SecondStep(controller: controller),
            ThirdStep(controller: controller),
            FourthStep(controller: controller),
          ],
        ),
      ),
    );
  }
}
