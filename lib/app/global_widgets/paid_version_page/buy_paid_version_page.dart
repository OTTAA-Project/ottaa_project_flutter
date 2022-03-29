import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/global_widgets/paid_version_page/local_widgets/right_side_paid_version.dart';
import 'package:ottaa_project_flutter/app/global_widgets/paid_version_page/local_widgets/left_side_paid_version.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/ottaa_project_custom_icons_icons.dart';

class BuyPaidVersionPage extends StatelessWidget {
  const BuyPaidVersionPage({
    Key? key,
    required this.iconAddress,
    required this.text,
  }) : super(key: key);
  final IconData iconAddress;
  final String text;

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final horizontalSize = MediaQuery.of(context).size.width;
    //todo: create a pageViewer for this widget and implement it for the 5 seconds interval.
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: kOTTAAOrangeNew,
        // leading: Container(),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalSize * 0.03,
          horizontal: horizontalSize * 0.02,
        ),
        child: Row(
          children: [
            /// here is the left side of the widget for the paid version screen
            LeftSidePaidVersion(
              text: text,
              // iconAddress: Ottaa_project_custom_icons.map_marked,
              // iconAddress: Icons.videogame_asset,
              // iconAddress: Icons.accessible_forward,
              iconAddress: iconAddress,
            ),
            SizedBox(
              width: horizontalSize * 0.02,
            ),

            /// here is the right hand widget for the paid version screen
            RightSidePaidVersion(),
          ],
        ),
      ),
    );
  }
}
