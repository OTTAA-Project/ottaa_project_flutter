import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/locator.config.dart';
import 'package:ottaa_project_flutter/application/service/service.dart';
import 'package:ottaa_project_flutter/application/use_cases/learn_pictogram_impl.dart';
import 'package:ottaa_project_flutter/application/use_cases/predict_pictogram_impl.dart';
import 'package:ottaa_project_flutter/application/use_cases/use_cases.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'package:ottaa_project_flutter/core/use_cases/learn_pictogram.dart';
import 'package:ottaa_project_flutter/core/use_cases/predict_pictogram.dart';
import 'package:ottaa_project_flutter/core/use_cases/use_cases.dart';

final getIt = GetIt.instance;

const mobile = Environment('mobile');
const web = Environment('web');

@InjectableInit(
  preferRelativeImports: false,
  throwOnMissingDependencies: true,
)
Future<GetIt> configureDependencies() => getIt.init(
      environment: kIsWeb ? "web" : "mobile",
    );
