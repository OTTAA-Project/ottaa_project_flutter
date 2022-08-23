import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/global_widgets/mini_picto_widget.dart';

class SpeakPicWidget extends StatelessWidget {
  final Pict? pict;
  final Function speak;

  const SpeakPicWidget({Key? key, required this.pict, required this.speak}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pict speakPict = Pict(
      localImg: true,
      id: 0,
      texto: Texto(en: "", es: ""),
      tipo: 6,
      imagen: Imagen(picto: "logo_ottaa_dev"),
    );
    if (pict != null) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: MiniPicto(
          localImg: pict!.localImg,
          pict: pict!,
          onTap: () {
            speak();
          },
        ),
      );
    } else {
      return Bounce(
        from: 6,
        infinite: true,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: MiniPicto(
            localImg: speakPict.localImg,
            pict: speakPict,
            onTap: () {
              speak();
            },
          ),
        ),
      );
    }
  }
}
