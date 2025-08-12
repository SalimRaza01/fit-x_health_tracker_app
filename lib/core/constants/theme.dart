import 'package:flutter/material.dart';


  InputDecoration darkInputDecor({
    String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: const Color(0xFF1F2225),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
