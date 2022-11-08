import 'dart:async';

import 'package:flutter/material.dart';

abstract class SplashRepository {
  Future<void> isCurrentUserAvatarExist({required BuildContext context});

  Future<bool> isLoggedIn();
}
