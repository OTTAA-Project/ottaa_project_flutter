import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

class RightSidePaidVersion extends StatelessWidget {
  const RightSidePaidVersion({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalSize * 0.01,
          horizontal: horizontalSize * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(verticalSize * 0.01),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    'price_one'.tr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunch(url)){
                    await launch(url);
                  }
                  else {
                    print('no');
                    // can't launch url
                  }
                },
                child: Container(
                  color: Colors.lightGreen,
                  child: Center(
                    child: Text(
                      'purchase_subscription'.tr,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: verticalSize * 0.01,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Get.offAllNamed(AppRoutes.LOGIN),
                child: Container(
                  color: Colors.black12,
                  child: Center(
                    child: Text(
                      'login'.tr.toUpperCase(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
