import 'package:flutter/material.dart';

class HeaderWave extends StatelessWidget {
  final Color color;
  final Color bgColor;

  const HeaderWave({Key? key, required this.color, this.bgColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWavePainter(color),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  final Color color;

  _HeaderWavePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    lapiz.color = color; //Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = Path();

    // Dibujar con el path y el lapiz
    // path.moveTo(0, size.height);
    // path.lineTo(0, size.height * 0.8);
    // path.quadraticBezierTo(size.width * 0.25, size.height * 0.8,
    //     size.width * 0.5, size.height * 0.85);
    // path.quadraticBezierTo(
    //     size.width * 0.75, size.height * 0.9, size.width, size.height * 0.85);
    // path.lineTo(size.width, size.height);

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.5, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.3, size.width * 0.45, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.75, size.width * 0.45, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
