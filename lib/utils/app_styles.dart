import 'package:flutter/material.dart';
import 'package:login_yahya/utils/app_colors.dart';
//import 'package:google_fonts/google_fonts.dart';

class StylesApp {
  static TextStyle titleStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static TextStyle titleDescStyle =
      const TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
  static TextStyle normalStyle =
      const TextStyle(fontSize: 10, fontWeight: FontWeight.normal);
  static TextStyle itemNameStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primaryColor);
  // static const TextStyle normalStyle =
  //     TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle priceNormalStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.scondryColor);

  static TextStyle categoryNormalStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.scondryColor);
  static TextStyle categoryNormalStyleSelect = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.white);
  static TextStyle minusStyleSelect = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.white);
  static TextStyle calcStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.grey);
  static TextStyle totalStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.scondryColor);
}
