import 'package:flutter/material.dart';
import 'package:meoscleanarchitecture/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String caption;
  final VoidCallback onPressed;
  const AuthGradientButton(
      {super.key, required this.caption, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          borderRadius: BorderRadius.circular(7)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.maxFinite, 55),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child: Text(
          caption,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
