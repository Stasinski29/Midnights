import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midnights/utils/app_colors.dart';

class InputDecorationComponent extends InputDecoration {
  InputDecorationComponent(String hint)
      : super(
          hintText: hint,
          hintStyle: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontSize: 14,
              color: AppColors.mainColor.withOpacity(0.6),
              fontWeight: FontWeight.w400,
            ),
          ),
          labelStyle: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.mainColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          focusColor: Colors.red,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.mainColor,
              width: 5.0,
              style: BorderStyle.solid,
            ),
          ),
          filled: false,
        );
}
