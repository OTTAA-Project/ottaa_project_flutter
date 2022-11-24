import 'package:flutter/material.dart';

class ProfileChooserScreen extends StatelessWidget {
  const ProfileChooserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            //todo: add text style here after emir has created the theme files
            child: Text('Omitir'),
          ),
        ],
      ),
    );
  }
}
