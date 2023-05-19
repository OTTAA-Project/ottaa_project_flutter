import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/core/enums/user_payment.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';

class AboutProvider extends ChangeNotifier {
  final AboutRepository aboutService;

  AboutProvider(this.aboutService);

  Future<String> getAppVersion() => aboutService.getAppVersion();

  Future<String> getAvailableAppVersion() =>
      aboutService.getAvailableAppVersion();

  Future<String> getDeviceName() => aboutService.getDeviceName();

  Future<String> getEmail() => aboutService.getEmail();

  Future<String> getProfilePicture() => aboutService.getProfilePicture();

  Future<UserPayment> getUserType() => aboutService.getUserType();

  Future<void> sendSupportEmail() => aboutService.sendSupportEmail();

  Future<void> uploadProfilePicture(String network, String asset) =>
      aboutService
          .uploadProfilePicture(AssetsImage(asset: asset, network: network));

  Future<void> uploadUserInformation() => aboutService.uploadUserInformation();
}

final aboutProvider = ChangeNotifierProvider<AboutProvider>((ref) {
  final AboutRepository aboutService = GetIt.I.get<AboutRepository>();
  return AboutProvider(aboutService);
});
