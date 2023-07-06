import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/choose_picto_day_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/create_pictogram_initial_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/ui/day_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/ui/time_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CreateBoardScreen extends ConsumerWidget {
  const CreateBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: OTTAAAppBar(
        title: Text(
          'create.create_new_board'.trl,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BoardWidget(),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'global.image'.trl,
                    style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DialogWidget(
                        image: AppImages.kArsacImage,
                        text: 'global.arasaac'.trl,
                        onTap: () {
                          context.push(AppRoutes.patientEditPictoarsaac);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DialogWidget(
                          image: AppImages.kCameraIcon,
                          text: 'shortcut.customize.camera'.trl,
                          onTap: () async {
                            final res = await provider.captureImageFromCamera();
                            if (res) {
                              provider.isUrl = false;
                              provider.notify();
                            }
                          },
                        ),
                      ),
                      DialogWidget(
                        image: AppImages.kGalleryIcon,
                        text: 'global.gallery'.trl,
                        onTap: () async {
                          final res = await provider.captureImageFromGallery();
                          if (res) {
                            provider.isUrl = false;
                            provider.notify();
                          }
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'global.text'.trl,
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: provider.nameController,
                          onChanged: (text) {
                            provider.notify();
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        height: 50,
                        width: 58,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(colorScheme.primary),
                            overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(9)),
                              ),
                            ),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          onPressed: () async {
                            await provider.speakWord();
                          },
                          child: Center(
                            child: Image.asset(
                              AppImages.kOttaaMinimalist,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'global.predictive'.trl,
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'create.time_sub1'.trl,
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      DayWidget(text: 'global.sunday'.trl),
                      DayWidget(text: 'global.monday'.trl),
                      DayWidget(text: 'global.tuesday'.trl),
                      DayWidget(text: 'global.wednesday'.trl),
                      DayWidget(text: 'global.thursday'.trl),
                      DayWidget(text: 'global.friday'.trl),
                      DayWidget(text: 'global.saturday'.trl),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'create.schedule'.trl,
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TimeWidget(text: 'global.tomorrow'.trl),
                      TimeWidget(text: 'global.noon'.trl),
                      TimeWidget(text: 'global.late'.trl),
                      TimeWidget(text: 'global.evening'.trl),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SimpleButton(
                  onTap: () async {
                    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
                    if (provider.isEditBoard) {
                      await provider.saveChangesInBoard();
                    } else {
                      await provider.saveAndUploadGroup();
                    }
                    context.pop();
                    context.pop();
                  },
                  text: 'global.save'.trl,
                  width: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoardWidget extends ConsumerWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          provider.isImageSelected
              ? provider.isUrl
                  ? Image.network(
                      provider.imageUrlForPicto,
                      height: 90,
                      width: 90,
                    )
                  : Image.file(
                      File(
                        provider.imageForPicto.path,
                      ),
                      height: 90,
                      width: 90,
                    )
              : Image.asset(
                  AppImages.kBoardSelectImage,
                  height: 90,
                  width: 90,
                ),
          Text(
            provider.nameController.text.isEmpty ? 'create.board_name'.trl : provider.nameController.text,
            style: textTheme.bodyMedium!.copyWith(
              color: provider.nameController.text.isEmpty ? Colors.grey : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
