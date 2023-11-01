import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopuro/constants/app/app_colors.dart';

@immutable
final class AppTextStyles {
  static  TextStyle header1 =  GoogleFonts.firaSans(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.main);
  static  TextStyle header2 = GoogleFonts.firaSans(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black);
  static  TextStyle header3 = GoogleFonts.firaSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  static  TextStyle header4 = GoogleFonts.firaSans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);


}