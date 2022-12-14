import 'package:flutter/material.dart';

class NewTextWidget extends StatelessWidget {
  const NewTextWidget({
    Key? key,
    required this.hintText,
  }) : super(key: key);
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    //todo: add the theme here and also add the text editor here
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(
      //     color: Colors.black,
      //     width: 0.5,
      //   ),
      // ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(16.0)),
          //   borderSide: BorderSide(color: Colors.black, width: 1),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          hintStyle:
              textTheme.headline3!.copyWith(color: colorScheme.onSurface),
          contentPadding: const EdgeInsets.only(left: 16),
        ),
        style: textTheme.headline3,
      ),
    );
  }
}
