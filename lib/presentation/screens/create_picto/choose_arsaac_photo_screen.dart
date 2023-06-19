import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/create_picto_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';

class ChooseArsaacPhotoScreen extends ConsumerWidget {
  const ChooseArsaacPhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(createPictoProvider);
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SimpleButton(
              onTap: () async {
                await provider.fetchPhotoFromGlobalSymbols(text: '');
              },
              text: 'hello',
            ),
          ),
        ],
      ),
    );
  }
}
