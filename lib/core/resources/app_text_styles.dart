import 'package:flutter/material.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_fonts.dart';

// =========================== App Text =========================== //
class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    required this.style,
    this.align,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

// =========================== App TextStyle =========================== //
class AppTextStyles {
  // ----------------------- Info ----------------------- //
  // Text Styles (with usage)
  // Display – 32 → For very large text, like app banners or splash headlines.
  // Heading – 24 → For main screen titles or section headers.
  // Title – 20 → For card titles or important labels inside a page.
  // Highlight – 18 → For emphasized text, key info, or short highlights.
  // Subtitle – 16 → For supportive text under titles, or secondary headings.
  // Body – 14 → For general paragraph text and most content.
  // Caption – 12 → For helper text, footnotes, or small descriptions.
  // Label – 10 → For tags, tiny buttons, or very small UI elements.
  // Reg=> Regular --- Med=> Medium --- Semi=> SemiBold --- Bold=> Bold --- Extra=> ExtraBold

  // ----------------------- Display => 32 ----------------------- //
  // ------ base ------ //
  static final TextStyle _displayBase = TextStyle(
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
    color: AppColors.mainTextColor,
  );

  // ------ Styles ------ //
  static final TextStyle displayBlackBold = _displayBase;
  // ----------------------- Heading => 24 ----------------------- //
  // ------ base ------ //
  static final TextStyle _headingBase = TextStyle(
    fontSize: 24,
    fontWeight: AppFontWeight.bold,
    color: AppColors.mainTextColor,
  );

  // ------ Styles ------ //
  static final TextStyle headingMain = _headingBase;
  // ----------------------- Title => 20 ----------------------- //
  // ------ base ------ //
  static final TextStyle _titleSBase = TextStyle(
    fontSize: 20,
    fontWeight: AppFontWeight.medium,
  );

  // ------ Styles ------ //
  static final TextStyle titleMedGrey = _titleSBase.copyWith(
    color: AppColors.nearBlueGrey,
  );
  static final TextStyle titleMedBlack = _titleSBase.copyWith(
    color: AppColors.mainTextColor,
  );

  // ----------------------- Highlight => 18 ----------------------- //
  // ------ base ------ //
  static final TextStyle _highlightBase = TextStyle(
    fontSize: 18,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.secondTextColor,
  );

  // ------ Styles ------ //
  static final TextStyle highlightWhiteSemi = _highlightBase;
  static final TextStyle highlightBlackSemi = _highlightBase.copyWith(
    color: AppColors.mainTextColor,
  );
  static final TextStyle highlightBlackBold = _highlightBase.copyWith(
    color: AppColors.mainTextColor,
    fontWeight: AppFontWeight.bold,
  );
  static final TextStyle highlightBlackReg = _highlightBase.copyWith(
    color: AppColors.mainTextColor,
    fontWeight: AppFontWeight.regular,
  );
  static final TextStyle highlightWhiteMed = _highlightBase.copyWith(
    color: AppColors.secondTextColor,
    fontWeight: AppFontWeight.medium,
  );

  // ----------------------- Subtitle => 16 ----------------------- //
  // ------ base ------ //
  static final TextStyle _subtitleBase = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.mainTextColor,
  );

  // ------ Styles ------ //
  static final TextStyle subtitleBlackSemi = _subtitleBase;
  static final TextStyle subtitleNearBlueGreySemi = _subtitleBase.copyWith(
    color: AppColors.nearBlueGrey,
  );


  // ----------------------- Body => 14 ----------------------- //
  // ------ base ------ //
  static final TextStyle _bodyBase = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.medium,
    color: AppColors.nearBlueGrey
  );
  // ------ Styles ------ //
  static final TextStyle bodyMedBlueGrey = _bodyBase;
  static final TextStyle bodyBoldBlueGrey = _bodyBase.copyWith(
    fontWeight: AppFontWeight.bold,
  );

  // ----------------------- Caption => 12 ----------------------- //
  // ------ base ------ //
  static final TextStyle _captionBase = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.nearBlueGrey,
  );

  // ------ Styles ------ //
  static final TextStyle captionBlueGreyReg = _captionBase;
  static final TextStyle captionBlueGreyMed = _captionBase.copyWith(
    fontWeight: AppFontWeight.medium,
  );


}
