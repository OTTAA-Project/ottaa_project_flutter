import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizedBoardScreen extends StatefulWidget {
  const CustomizedBoardScreen({Key? key}) : super(key: key);

  @override
  State<CustomizedBoardScreen> createState() => _CustomizedBoardScreenState();
}

class _CustomizedBoardScreenState extends State<CustomizedBoardScreen> {
  int index = 1;
  bool status = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //todo: emir fix it again XD
              OTTAAAppBar(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "board.customize.title".trl,
                      style: textTheme.headline3,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.help_outline_rounded,
                        size: 24,
                      ),
                      onPressed: () => BasicBottomSheet.show(
                        context,
                        // title: "",
                        subtitle: "helpText".trl,
                        children: <Widget>[
                          Image.asset(
                            AppImages.kBoardImageEdit1,
                            height: 166,
                          ),
                        ],
                        okButtonText: "okText".trl,
                      ),
                      padding: const EdgeInsets.all(0),
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
                actions: [
                  Text(
                    "Omitir".trl,
                    style: textTheme.headline4!
                        .copyWith(color: colorScheme.onSurface),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 16, top: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 32,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 12,
                          width: 16,
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Paso $index/2",
                          style: textTheme.headline4!
                              .copyWith(color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "board.customize.heading".trl,
                      style: textTheme.headline3!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Expanded(
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
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                onPressed: () {},
                //todo: add text here after discussing with the team
                text: "Continuar".trl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
