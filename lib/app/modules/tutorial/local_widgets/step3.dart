import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

step3<widget>(PageController controller) => Container(
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(),
          ),
          SvgPicture.asset(
            'assets/Group 729.svg',
            placeholderBuilder: (BuildContext context) =>
                Container(child: const CircularProgressIndicator()),
          ),
          Column(
            children: [
              Text(
                "ACCEDE A MILES DE PICTOGRAMAS",
                style: GoogleFonts.montserratAlternates(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                maxLines: 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 300),
                child: Text(
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
              IconButton(
                onPressed: () => controller.animateToPage(1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                iconSize: 150,
                icon: SvgPicture.asset(
                  'assets/Group 731.svg',
                ),
              ),
              IconButton(
                onPressed: () => controller.animateToPage(3,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                iconSize: 150,
                icon: SvgPicture.asset(
                  'assets/Group 732_.svg',
                ),
              ),
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    );
