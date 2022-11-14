import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/report_provider.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class MostUsedPhrasesWidget extends ConsumerWidget {
  const MostUsedPhrasesWidget({
    required this.pageController,
    Key? key,
  }) : super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    final provider = ref.watch(reportProvider);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          verticalSize * 0.01,
        ),
      ),
      padding: EdgeInsets.all(verticalSize * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'most_used_phrases'.trl,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              // fontSize: verticalSize * 0.022,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.02),
              child: PageView.builder(
                controller: pageController,
                itemCount: 4,
                itemBuilder: (context, indexMain) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(
                        horizontalSize * 0.01,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        provider.loadingMostUsedSentences
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: provider.mostUsedSentences[indexMain].length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, indexSecond) {
                                    return Container(
                                      padding: EdgeInsets.only(left: verticalSize * 0.01),
                                      height: verticalSize * 0.15,
                                      width: verticalSize * 0.15,
                                      child: Image.network(provider.mostUsedSentences[indexMain][indexSecond]),
                                    );
                                  },
                                ),
                              )
                            : const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: kOTTAAOrangeNew,
                                  ),
                                ),
                              ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: verticalSize * 0.03),
                            child: Image.asset(
                              AppImages.kOttaaDrawerLogo,
                              height: verticalSize * 0.05,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
