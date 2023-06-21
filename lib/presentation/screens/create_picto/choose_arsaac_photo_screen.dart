import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_ui_kit/widgets.dart';
import 'package:picto_widget/picto_widget.dart';

class ChooseArsaacPhotoScreen extends ConsumerWidget {
  const ChooseArsaacPhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: OTTAAAppBar(
        title: Text(
          "create.search_arsaac".trl,
          style: textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    await provider.fetchPhotoFromGlobalSymbols(text: provider.arsaacController.text);
                    provider.searchedData.removeWhere((e) => e.picto.imageUrl.contains('.svg'));
                    context.pop();
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                hintText: 'global.search'.trl,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            provider.isArsaacSearched
                ? Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      itemCount: provider.searchedData.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) => FittedBox(
                        fit: BoxFit.contain,
                        child: PictoWidget(
                          onTap: () {
                            provider.isImageSelected = true;
                            provider.imageUrlForPicto = provider.searchedData[index].picto.imageUrl;
                            provider.notify();
                            context.pop();
                          },
                          imageUrl: provider.searchedData[index].picto.imageUrl,
                          text: '',
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        'global.please_enter_text'.trl,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
