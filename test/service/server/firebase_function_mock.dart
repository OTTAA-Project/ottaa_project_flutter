// ignore_for_file: require_trailing_commas
// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_functions_platform_interface/cloud_functions_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = Function(MethodCall call);

const String kTestString = 'Hello World';
const String kBucket = 'gs://fake-storage-bucket-url.com';
const String kSecondaryBucket = 'gs://fake-storage-bucket-url-2.com';

class MockHttpsCallablePlatform extends HttpsCallablePlatform {
  MockHttpsCallablePlatform(FirebaseFunctionsPlatform functions, String? origin,
      String? name, HttpsCallableOptions options, Uri? uri)
      : super(functions, origin, name, options, uri);

  @override
  Future<dynamic> call([dynamic parameters]) async {
    // For testing purpose we return input data as output data.
    return parameters;
  }
}
