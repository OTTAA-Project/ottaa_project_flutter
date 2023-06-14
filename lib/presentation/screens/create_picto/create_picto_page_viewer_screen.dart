import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/choose_board_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/create_pictogram_initial_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/create_picto/ui/page_viewer_indicator_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class CreatePictoPageViewerScreen extends ConsumerWidget {
  const CreatePictoPageViewerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          'create.heading'.trl,
          style: textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const PageViewerIndicatorWidget(),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              flex: 1,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: provider.controller,
                children: [
                  const ChooseBoardScreen(),
                  const CreatePictogramInitialScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
