import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

final Map<int, Color> groupColor = {
  1: Colors.yellow,
  2: kOTTAOrange,
  3: Colors.green,
  4: Colors.blue,
  5: Colors.purple,
  6: Colors.black,
};

class Picto extends StatelessWidget {
  final Pict pict;
  final VoidCallback onTap;
  final double height;
  final double width;
  final languaje;

  const Picto({
    required this.pict,
    required this.onTap,
    required this.height,
    required this.width,
    required this.languaje,
  });

  @override
  Widget build(BuildContext context) {
    String texto;

    switch (this.languaje) {
      case "es-US":
        texto = pict.texto.es;
        break;
      case "en-US":
        texto = pict.texto.en;
        break;

      default:
        texto = pict.texto.es;
    }

    return GestureDetector(
      onTap: this.onTap,
      child: Container(
          height: this.height,
          width: this.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                //height: 320,
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: groupColor[pict.tipo],
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                        image: AssetImage(
                            'assets/imgs/${pict.imagen.picto}.webp')),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                    child: FittedBox(
                  // ver si queda o no el fit
                  child: Text(
                    texto.toUpperCase(),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                )),
              )),
            ],
          )),
    );
  }
}
