import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.image,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final String image, text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    //todo: add teh theme here
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 16,
                width: 16,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
