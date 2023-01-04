import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CustomizeBoardScreen extends ConsumerStatefulWidget {
  const CustomizeBoardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomizeBoardScreen> createState() =>
      _CustomizeBoardScreenState();
}

class _CustomizeBoardScreenState extends ConsumerState<CustomizeBoardScreen> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(customiseProvider);
    return provider.pictosFetched
        ? ListView.builder(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              width: MediaQuery.of(context).size.width - 48,
              child: Padding(
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
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
