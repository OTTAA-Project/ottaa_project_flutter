import 'package:flutter/material.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size? size;

  final ButtonStyle Function(ButtonStyle)? buildTheme;

  const HomeButton({
    super.key,
    this.onPressed,
    required this.child,
    this.buildTheme,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    bool disabled = onPressed == null;

    final defaultTheme = ButtonStyle(
      fixedSize: MaterialStateProperty.all(size),
      backgroundColor: MaterialStateProperty.all(disabled ? Colors.grey.withOpacity(.12) : Colors.white),
      foregroundColor: MaterialStateProperty.all(disabled ? colorScheme.primary.withOpacity(.12) : colorScheme.primary),
      iconColor: MaterialStateProperty.all(disabled ? colorScheme.primary.withOpacity(.12) : colorScheme.primary),
      overlayColor: MaterialStateProperty.all(colorScheme.primary.withOpacity(0.1)),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
      ),
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      elevation: MaterialStateProperty.all(0),
    );

    return BaseButton(
      onPressed: onPressed,
      style: buildTheme != null
          ? buildTheme!(
              defaultTheme,
            )
          : defaultTheme,
      child: child,
    );
  }
}
