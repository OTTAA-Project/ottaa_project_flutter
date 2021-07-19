import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

step4<widget>(PageController controller) => Container(
      color: Colors.grey.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(),
          ),
          SvgPicture.asset(
            'assets/Group 727.svg',
            placeholderBuilder: (BuildContext context) =>
                Container(child: const CircularProgressIndicator()),
          ),
          Column(
            children: [
              Text(
                "JUEGA Y APRENDE",
                style: GoogleFonts.montserratAlternates(
                    fontSize: 50,
                    color: Colors.orange,
                    fontWeight: FontWeight.w600),
                maxLines: 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 300),
                child: Text(
                  "Entra a la selección de juegos para aprender jugando. OTTAA cuenta con juegos didácticos para aprender vocabulario, conceptos y mucho más. Además, pronto habrá más juegos disponibles!.",
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
                onPressed: () => controller.animateToPage(2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut),
                iconSize: 150,
                icon: SvgPicture.asset(
                  'assets/Group 731.svg',
                ),
              ),
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.HOME),
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
