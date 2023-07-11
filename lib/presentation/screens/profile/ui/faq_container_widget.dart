import 'package:flutter/material.dart';

class FaqContainerWidget extends StatelessWidget {
  const FaqContainerWidget({
    Key? key,
    required this.selected,
    required this.subtitle,
    required this.heading,
    required this.onTap,
  }) : super(key: key);
  final bool selected;
  final String subtitle, heading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: selected
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )
                    : BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    heading,
                  ),
                  selected
                      ? const Icon(
                          Icons.close,
                        )
                      : const Icon(
                          Icons.add,
                        ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: selected ? 104 : 0,
              width: MediaQuery.of(context).size.width - 48,
              child: selected
                  ? SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Divider(
                            height: 3,
                            color: colorScheme.background,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: colorScheme.onPrimary,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Text(
                              subtitle,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
