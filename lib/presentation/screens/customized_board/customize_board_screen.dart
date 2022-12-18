import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizeBoardScreen extends StatefulWidget {
  const CustomizeBoardScreen({Key? key}) : super(key: key);

  @override
  State<CustomizeBoardScreen> createState() => _CustomizeBoardScreenState();
}

class _CustomizeBoardScreenState extends State<CustomizeBoardScreen> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding:
        const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          //todo: plavce holder values
          child: PictogramCard(
            title: "title",
            actionText: "actionText",
            //todo: a holder for the picto
            pictogram: AssetImage(AppImages.kAbrigos),
            status: status,
            onChange: (bool a) {
              print('tapped');
              setState(() {
                status = !status;
              });
            },
            onPressed: () {
              //todo: if needed to be implemented
              print('pressed');
            },
          ),
        ),
      ),
    );
  }
}
