import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color buttonColor;
  const CustomButton({super.key, required this.onTap, required this.text,required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 250,
      height: 60,
      onPressed:onTap,
      color:buttonColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),

      ),
      child: Text(
        text, style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: Colors.white,
        ),
        ),

    );
  }
}
