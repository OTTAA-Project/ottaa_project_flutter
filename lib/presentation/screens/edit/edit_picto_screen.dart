import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/application/providers/view_board_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/choose_color_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/choose_picto_day_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/create_pictogram_initial_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/ui/day_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/ui/time_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/widgets/image_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class EditPictoScreen extends ConsumerWidget {
  const EditPictoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.watch(createPictoProvider);
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text('create.edit_picto'.trl),
        actions: [
          GestureDetector(
            onTap: () {
              //todo: add the delete implementation
              //todo: add the check for the tags in the pictos
            },
            child: const Icon(
              Icons.delete_outline_rounded,
              size: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: ImageWidget(
                  onTap: () {},
                ),
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'global.color'.trl,
                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  ColorWidget(
                    color: Colors.green,
                    text: 'global.actions'.trl,
                    number: 3,
                  ),
                  ColorWidget(
                    color: Colors.yellow,
                    text: 'global.people'.trl,
                    number: 1,
                  ),
                  ColorWidget(
                    color: Colors.black,
                    text: 'global.miscellaneous'.trl,
                    number: 6,
                  ),
                  ColorWidget(
                    color: Colors.purple,
                    text: 'user.main_setting.interaction'.trl,
                    number: 5,
                  ),
                  ColorWidget(
                    color: colorScheme.primary,
                    text: 'global.noun'.trl,
                    number: 2,
                  ),
                  ColorWidget(
                    color: Colors.blue,
                    text: 'global.adjective'.trl,
                    number: 4,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'global.saved_in'.trl,
                  style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              provider.selectedBoardID == -1
                  ? const SizedBox.shrink()
                  : PictogramCard(
                      onPressed: () {
                        //todo: ask from hector
                      },
                      title: provider.boards[provider.selectedBoardID].text,
                      actionText: '${'global.edit'.trl} ${'global.location'.trl}',
                      pictogram: CachedNetworkImageProvider(provider.boards[provider.selectedBoardID].resource.network!),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SimpleButton(
                  onTap: () async {
                    final pro = ref.read(viewBoardProvider);
                    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
                    await provider.saveChangesInPicto(id: provider.selectedPictoForEditId);
                    context.pop();
                    context.pop();
                    pro.filterPictosForView();
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
