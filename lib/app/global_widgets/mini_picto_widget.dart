import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';

class MiniPicto extends StatelessWidget {
  final Pict pict;
  final VoidCallback onTap;

  const MiniPicto({required this.pict, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
            color: Colors.white,
            child: Image(
                image: AssetImage('assets/imgs/${pict.imagen.picto}.webp'))),
      ),
    );
  }
}
