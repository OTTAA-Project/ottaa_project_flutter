import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class AboutController extends GetxController {
  RxString userEmail = ''.obs;
  RxString userSubscription = ''.obs;
  RxString currentOTTAAInstalled = ''.obs;
  RxString currentOTTAAVersion = ''.obs;
  RxString deviceName = ''.obs;
  final _dataController = Get.find<DataController>();

  Future<void> fetchAccountInfo() async {
    // final auth = FirebaseAuth.instance.currentUser!.providerData[0].email;
    final auth = await _dataController.fetchUserEmail();
    userEmail.value = auth;
  }

  Future<void> fetchInstalledVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    currentOTTAAInstalled.value = version;
  }

  Future<void> fetchDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceName.value = webBrowserInfo.userAgent!;
      print('Browser name is this: 101 ${webBrowserInfo.userAgent!}');
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName.value = androidInfo.model!;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        deviceName.value = iosDeviceInfo.utsname.machine!;
      }
    }
  }

  Future<void> fetchAccountType() async {
    // final User? auth = FirebaseAuth.instance.currentUser;
    // final ref = databaseRef.child('Pago/${auth!.uid}/Pago');
    // final res = await ref.get();
    final res = await _dataController.fetchAccountType();

    /// this means there is a value
    if (res == 1) {
      userSubscription.value = 'Premium';
    } else {
      userSubscription.value = 'Free';
    }
    print('the user type is ${userSubscription.value}');
  }

  Future<void> fetchCurrentVersion() async {
    // final ref = databaseRef.child('version/');
    // final res = await ref.get();
    final double res = await _dataController.fetchCurrentVersion();
    currentOTTAAVersion.value = res.toString();
  }

  Future<void> launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'support@ottaaproject.com',
        queryParameters: {
          'subject': 'Support',
          'body':
              '''Account: ${userEmail.value},\nAccount Type: ${userSubscription.value},\nCurrent OTTAA Installed: ${currentOTTAAInstalled.value}\nCurrent OTTAA Version: ${currentOTTAAVersion.value}\nDevice Name: ${deviceName.value}''',
        });
    String url = params.toString();
    final value = url.replaceAll('+', ' ');
    if (await canLaunch(value)) {
      await launch(value);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchInstalledVersion();
    await fetchAccountType();
    await fetchCurrentVersion();
    await fetchDeviceName();
    await fetchAccountInfo();
  }
}
