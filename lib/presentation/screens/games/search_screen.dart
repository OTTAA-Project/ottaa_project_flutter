import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/background_widget.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/ui/header_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundWidget(),
          Positioned(
            left: 24,
            top: 24,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: colorScheme.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 18,
                    ),
                  ),
                ),
                Text(
                  'game.search'.trl,
                  style: textTheme.headline3,
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.25,
            left: size.width / 4,
            child: Column(
              children: [
                SizedBox(
                  width: 400,
                  child: TextFormField(),
                ),
                const SizedBox(
                  height: 36,
                ),
                Image.asset(
                  AppImages.kGameSearch,
                  height: 180,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
