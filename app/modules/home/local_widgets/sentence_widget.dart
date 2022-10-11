import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/mini_picto_widget.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_controller.dart';

class SentenceWidget extends StatelessWidget {
  const SentenceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;

    return GetBuilder<HomeController>(
      id: "sentence",
      builder: (_) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // SENTENCE ROW
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: verticalSize * 0.2,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _.sentencePicts.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  final Pict speakPict = Pict(
                      id: 0,
                      texto: Texto(en: "", es: ""),
                      tipo: 6,
                      imagen: Imagen(picto: "logo_ottaa_dev"));
                  if (_.sentencePicts.length > index) {
                    final Pict pict = _.sentencePicts[index];
                    return FadeInDown(
                      from: 30,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: MiniPicto(
                          pict: pict,
                          onTap: () {
                            _.speak();
                          },
                        ),
                      ),
                    );
                  } else {
                    return Bounce(
                      from: 6,
                      infinite: true,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: MiniPicto(
                          pict: speakPict,
                          onTap: () {
                            _.speak();
                          },
                        ),
                      ),
                    );
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
