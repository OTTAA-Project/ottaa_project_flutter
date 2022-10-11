import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Injector extends StatelessWidget {
  final Widget application;

  const Injector({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: application);
  }
}
