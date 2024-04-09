import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopuro/constants/app/app_colors.dart';

@immutable
final class AppTextStyles {
  static TextStyle main28 = GoogleFonts.firaSans(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.main,
  );

  static TextStyle main19 = GoogleFonts.firaSans(
    color: AppColors.main,
    fontSize: 19,
    fontWeight: FontWeight.w900,
  );
  static TextStyle main18 = GoogleFonts.firaSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.main,
  );
  static TextStyle main14 = GoogleFonts.firaSans(
    fontSize: 14,
    color: AppColors.main,
    fontWeight: FontWeight.w500,
  );
  static TextStyle black24 = GoogleFonts.firaSans(
    fontSize: 24,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );

  static TextStyle black22 = GoogleFonts.firaSans(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle black20 = GoogleFonts.firaSans(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle black19 = GoogleFonts.firaSans(
    fontSize: 19,
    fontWeight: FontWeight.w500,
  );
  static TextStyle black16 = GoogleFonts.firaSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );
  static TextStyle black14 = GoogleFonts.firaSans(
    fontSize: 14,
    color: Colors.black,
  );

  static TextStyle white14bold = GoogleFonts.firaSans(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
    static TextStyle white16bold = GoogleFonts.firaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
    static TextStyle white28bold = GoogleFonts.rubik(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle white14 = GoogleFonts.firaSans(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static TextStyle errorText = GoogleFonts.firaSans(
    color: Colors.red,
    fontSize: 16,
  );
   static TextStyle primary16 = GoogleFonts.firaSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
  );
   static TextStyle primary13 = GoogleFonts.firaSans(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
  );
}
