
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

  /// Returns an SvgPicture from assets
   SvgPicture getSvgIcon(String assetPath, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }

  void showSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blueAccent,  // You can customize this color
          duration: const Duration(seconds: 2),  // Default duration is set to 4 seconds
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),  // Rounded corners
          ),
          margin: EdgeInsets.all(10),  // Add some margin around the snackbar
          behavior: SnackBarBehavior.floating,  // Floating snackbar (not anchored to the bottom)
          action: SnackBarAction(
            label: 'UNDO',  // Optional action
            onPressed: () {
              // Implement your action here, e.g., undo something
              print('Undo action clicked');
            },
            textColor: Colors.white,
          ),
        ),
      );
    }
  }



