import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/home_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';

class ExitWidget extends StatelessWidget {
  const ExitWidget({Key? key, this.isLongClick = false}) : super(key: key);
  final bool isLongClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: isLongClick ? 280 : 210,
        width: 310,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: isLongClick ? const LongClickWidget() : const TapWidget(),
      ),
    );
  }
}

class LongClickWidget extends ConsumerWidget {
  const LongClickWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              provider.isExit = false;
              provider.notify();
            },
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'exit.long.headline'.trl,
            style: textTheme.headline3!.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'exit.long.body'.trl,
          style: textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SimpleButton(
            width: false,
            onTap: () async {
              provider.isExit = false;
              if (provider.isLongClickCheck) {
                provider.isExitLong = true;
                await provider.setLongClickEnabled(isLongClick: true);
              }
              provider.notify();
              context.pop();
            },
            text: 'exit.long.btn'.trl,
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: provider.isLongClickCheck,
              onChanged: (value) {
                provider.isLongClickCheck = value!;
                provider.notify();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: AutoSizeText(
                'exit.long.check'.trl,
                style: textTheme.bodyText1!.copyWith(color: Colors.black38, fontSize: 12),
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TapWidget extends ConsumerWidget {
  const TapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final provider = ref.watch(homeProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              provider.isExit = false;
              provider.notify();
            },
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          'exit.short.headline'.trl,
          style: textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            Expanded(
              child: SimpleButton(
                onTap: () {
                  provider.isExit = false;
                  provider.notify();
                },
                text: 'global.cancel'.trl,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: SimpleButton(
                onTap: () {
                  provider.isExit = false;
                  provider.notify();
                  context.pop();
                },
                text: 'global.confirm'.trl,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
