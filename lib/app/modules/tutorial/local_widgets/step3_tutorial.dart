import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

step3Tutorial<widget>(PageController controller, context) {
  double verticalSize = MediaQuery.of(context).size.height;
  double horizontalSize = MediaQuery.of(context).size.width;
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
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: horizontalSize * 0.05,
              child: FittedBox(
                child: Text(
                  "ACCEDE A MILES DE PICTOGRAMAS",
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.2),
              child: AutoSizeText(
                "En OTTAA tenés acceso a miles de pictogramas para que hables de lo que quieras. Encuentra la Galería de Pîctos en la esquina inferior izquierda de la pantalla principal.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserratAlternates(
                    fontSize: 20, color: Colors.white),
                maxLines: 3,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StepButton(
              text: "Anterior",
              leading: Icons.chevron_left,
              onTap: () => controller.animateToPage(1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut),
              backgroundColor: Colors.white,
              fontColor: Colors.grey,
            ),
            StepButton(
              text: "Siguiente",
              trailing: Icons.chevron_right,
              onTap: () => controller.animateToPage(3,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut),
              backgroundColor: Colors.white,
              fontColor: kOTTAOrange,
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
      ],
    ),
  );
}
