import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/application/providers/view_board_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:picto_widget/picto_widget.dart';

class PictogramScreen extends ConsumerWidget {
  const PictogramScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(viewBoardProvider);
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shrinkWrap: true,
        itemCount: provider.filteredPictos.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          if (provider.filteredPictos.length == index) {
            return FittedBox(
              fit: BoxFit.contain,
              child: PictoWidget(
                onTap: () async {
                  final pro = ref.read(createPictoProvider);
                  pro.init(userId: provider.userID);
                  context.push(AppRoutes.patientCreatePicto);
                },
                image: Image.asset(
                  AppImages.kAddIcon,
                ),
                text: 'global.add'.trl,
              ),
            );
          }
          return FittedBox(
            fit: BoxFit.contain,
            child: PictoWidget(
              onTap: () {
                //todo: ask from hector
              },
              onLongPress: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            color: Colors.transparent,
                            height: MediaQuery.of(context).size.height * 0.75,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        DialogButton(
                          text: 'global.disguise'.trl,
                          icon: Icons.hide_source_rounded,
                          onTap: () {
                            provider.hideCurrentPicto(id: provider.filteredPictos[index].id, index: index);
                            context.pop();
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DialogButton(
                          text: 'global.edit'.trl,
                          icon: Icons.edit,
                          onTap: () async {
                            final pro = ref.read(createPictoProvider);
                            await pro.init(userId: provider.userID);
                            await pro.setForPictoEdit(pict: provider.filteredPictos[index]);
                            context.push(AppRoutes.patientEditPicto);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              imageUrl: provider.filteredPictos[index].resource.network,
              text: provider.filteredPictos[index].text,
              colorNumber: provider.filteredPictos[index].type,
              disable: provider.filteredPictos[index].block,
            ),
          );
        },
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
