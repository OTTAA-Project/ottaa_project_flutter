import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

step1Tutorial<widget>(PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
  print(verticalSize);
  print(horizontalSize);
  return Container(
    color: kOTTAOrange,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(),
        ),
        Container(
          height: verticalSize * 0.3,
          child: FittedBox(
              child: SvgPicture.asset(
                'assets/Group 729.svg',
                placeholderBuilder: (BuildContext context) =>
                    Container(child: const CircularProgressIndicator()),
              ),
              fit: BoxFit.cover),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: horizontalSize * 0.05,
              child: FittedBox(
                child: Text(
                  "CREA TUS FRASES",
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.2),
              child: AutoSizeText(
                "Toca uno o más de los pictogramas para crear una frase tan larga cómo quieras. Los pictogramas se relacionan automáticamente y siempre tendrás un pictograma más para agregar.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserratAlternates(color: Colors.white),
                maxLines: 4,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        StepButton(
          text: "Siguiente",
          trailing: Icons.chevron_right,
          onTap: () => controller.animateToPage(1,
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
          backgroundColor: Colors.white,
          fontColor: kOTTAOrange,
        ),
        Expanded(
          child: Container(),
        ),
      ],
    ),
  );
}
