import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';

final locator = GetIt.instance;

Future<void> setupServices() async {
  //TODO: Register services

  final deviceLocale = Intl.getCurrentLocale().split("_")[0];
  final i18n = await I18N(deviceLocale).init();

  locator.registerSingleton<I18N>(i18n);
}
