import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? size;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.color,
    this.borderColor,
    this.textColor, this.fontWeight, this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: borderColor ?? AppColors.transparent,
              width: 2,
            ),
          ),
          onPressed: onPressed,
          icon: icon ?? const SizedBox(),
          label: Text(
            text,
            style: TextStyle(color: textColor ?? AppColors.white, fontSize: size, fontWeight: fontWeight ),
          ),
        ),
      ),
    );
  }
}
