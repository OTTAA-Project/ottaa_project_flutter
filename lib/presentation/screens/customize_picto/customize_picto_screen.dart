import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/presentation/screens/customize_picto/ui/board_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizePictoScreen extends StatefulWidget {
  const CustomizePictoScreen({Key? key}) : super(key: key);

  @override
  State<CustomizePictoScreen> createState() => _CustomizePictoScreenState();
}

class _CustomizePictoScreenState extends State<CustomizePictoScreen> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OTTAAAppBar(
              title: Row(
                children: [
                  Text(
                    "customize.picto.title".trl,
                    style: textTheme.headline3,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.help_outline_rounded,
                      size: 24,
                    ),
                    onPressed: () => BasicBottomSheet.show(
                      context,
                      // title: "",
                      subtitle: "board.customize.helpText".trl,
                      children: <Widget>[
                        Image.asset(
                          AppImages.kBoardImageEdit1,
                          height: 166,
                        ),
                      ],
                      okButtonText: "board.customize.okText".trl,
                    ),
                    padding: const EdgeInsets.all(0),
                    color: colorScheme.onSurface,
                  ),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    //todo: add the required things here
                  },
                  child: Text(
                    "board.customize.omitir".trl,
                    style: textTheme.headline4!
                        .copyWith(color: colorScheme.onSurface),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  BoardWidget(
                    title: "customize.picto.title".trl,
                    //todo: this one is a placeholder for now
                    image: const AssetImage(AppImages.kAbeja),
                    customizeOnTap: () {
                      print('customize on tap');
                    },
                    deleteOnTap: () {
                      print('customize on tap');
                    },
                    onChanged: (bool a) {
                      setState(() {
                        status = !status;
                      });
                    },
                    status: status,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 120,
                ),
                itemBuilder: (context, index) => Container(
                  color: Colors.pink,
                  height: 120,
                  width: 96,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
