import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

step2<widget>(PageController controller) => Container(
      color: Colors.grey.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(),
          ),
          SvgPicture.asset(
            'assets/Group 728.svg',
            placeholderBuilder: (BuildContext context) =>
                Container(child: const CircularProgressIndicator()),
          ),
          Column(
            children: [
              Text(
                "HABLA CON EL MUNDO",
                style: GoogleFonts.montserratAlternates(
                    fontSize: 50,
                    color: Colors.orange,
                    fontWeight: FontWeight.w600),
                maxLines: 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 300),
                child: Text(
                  "Una vez creada la frase, toca el logo de OTTAA par hablar en voz alta o usando el ícono de compartir, podrás enviar tu frase a través de las redes sociales más usadas.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserratAlternates(
                      fontSize: 20, color: Colors.black87),
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
                onPressed: () => controller.animateToPage(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                iconSize: 150,
                icon: SvgPicture.asset(
                  'assets/Group 731.svg',
                ),
              ),
              IconButton(
                onPressed: () => controller.animateToPage(2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                iconSize: 150,
                icon: SvgPicture.asset(
                  'assets/Group 732.svg',
                ),
              ),
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    );
