import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';

class OttaaLoading extends StatelessWidget {
  final String textToShow;

  const OttaaLoading({required this.textToShow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                    child: Image(
                        image: AssetImage('assets/imgs/logo_ottaa_dev.webp'))),
              ),
              Container(
                width: 179,
                height: 156,
                margin: EdgeInsets.only(top: 38),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TandamosCircularProgressIndicator(),
                    Text(
                      textToShow,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 117, 52),
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        letterSpacing: 0.26,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TandamosCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 90,
        width: 90,
        margin: EdgeInsets.only(bottom: 20),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(kOTTAOrange),
        ),
      ),
    );
  }
}
