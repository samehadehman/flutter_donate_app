import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String textElevated;
  final double height;
  final double width;
  final VoidCallback onPressed;
  const ElevatedButtonWidget({
    super.key,
    required this.textElevated,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        backgroundColor: Color(0xFFb3beb0),
      ),
      onPressed: onPressed,
      child: Text(
        textElevated,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}