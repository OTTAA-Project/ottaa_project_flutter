import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

step1<widget>(PageController controller) => Container(
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
                "CREA TUS FRASES",
                style: GoogleFonts.montserratAlternates(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                maxLines: 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 300),
                child: Text(
                  "Toca uno o más de los pictogramas para crear una frase tan larga cómo quieras. Los pictogramas se relacionan automáticamente y siempre tendrás un pictograma más para agregar.",
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
          IconButton(
            onPressed: () => controller.animateToPage(1,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
            iconSize: 150,
            icon: SvgPicture.asset(
              'assets/Group 732_.svg',
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
