import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/picto_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class SuggestedWidget extends StatelessWidget {
  const SuggestedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    double horizontalSize = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
      id: "suggested",
      builder: (_) => Bounce(
        from: 5,
        duration: Duration(seconds: 1),
        controller: (controller) => _.pictoAnimationController = controller,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: verticalSize * 0.52,
              width: horizontalSize * 0.78,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _.suggestedQuantity,
                itemBuilder: (BuildContext context, int index) {
                  if (_.suggestedPicts.isNotEmpty) {
                    final Pict pict = _.suggestedPicts[
                        index + _.suggestedIndex * _.suggestedQuantity];
                    return Container(
                      margin: EdgeInsets.all(horizontalSize / 99),
                      child: Picto(
                        height: verticalSize * 0.10,
                        width: horizontalSize * 0.175,
                        pict: pict,
                        languaje: _.ttsController.languaje,
                        onTap: () {
                          pict.texto.es != "agregar"
                              ? _.addPictToSentence(pict)
                              : print("AGREGAR");
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
