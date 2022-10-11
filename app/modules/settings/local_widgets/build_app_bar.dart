import 'package:flutter/material.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    // leading: Placeholder(),
    centerTitle: false,
    backgroundColor: Colors.grey[350],
  );
}
