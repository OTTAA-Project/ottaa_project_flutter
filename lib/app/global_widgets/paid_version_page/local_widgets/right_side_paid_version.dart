import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

class RightSidePaidVersion extends StatelessWidget {
  const RightSidePaidVersion({Key? key}) : super(key: key);

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
                    'Get access today to all the useful features that OTTAA Premium has to offer for only 990 ARS per month',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.lightGreen,
                child: Center(
                  child: Text(
                    'PURCHASE SUBSCRIPTION',
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
