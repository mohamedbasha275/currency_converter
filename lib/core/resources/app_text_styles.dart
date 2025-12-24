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


  // ----------------------- Display => 24 ----------------------- //
  // ------ base ------ //
  static final TextStyle _displayBase = TextStyle(
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
    color: AppColors.darkColor
  );

  // ------ Styles ------ //
  static final TextStyle displayBoldDark = _displayBase;
  // ----------------------- Heading => 24 ----------------------- //
  // ------ base ------ //
  static final TextStyle _headingBase = TextStyle(
    fontSize: 24,
    fontWeight: AppFontWeight.bold,
  );

  // ------ Styles ------ //
  static final TextStyle headingBoldNearBlack = _headingBase.copyWith(
    color: AppColors.label3Color,
  );
  static final TextStyle  headingPrimaryDark = _headingBase.copyWith(
    color: AppColors.primaryDark,
  );
  // ----------------------- Title => 20 ----------------------- //
  // ------ base ------ //
  static final TextStyle _titleSBase = TextStyle(
    fontSize: 20,
    fontWeight: AppFontWeight.medium,
  );

  // ------ Styles ------ //
  static final TextStyle titleMedNearWhite = _titleSBase.copyWith(
    color: AppColors.label1Color,
  );

  static final TextStyle titleRegDarkPrime = _titleSBase.copyWith(
    color: AppColors.darkPrimary,
    fontWeight: AppFontWeight.regular,
  );
// ----------------------- Highlight => 18 ----------------------- //
  // ------ base ------ //
  static final TextStyle _highlightBase = TextStyle(
    fontSize: 18,
    fontWeight: AppFontWeight.semiBold,
  );

  // ------ Styles ------ //
  static final TextStyle highlightSemi = _highlightBase.copyWith(
    color: AppColors.label1Color,
  );

  // ----------------------- Subtitle => 16 ----------------------- //
  // ------ base ------ //
  static final TextStyle _subtitleBase = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.semiBold,
  );

  // ------ Styles ------ //
  static final TextStyle subtitleSemi = _subtitleBase.copyWith(
    color: AppColors.nearBlackTextColor,
  );
  static final TextStyle subtitleSemiDark = _subtitleBase.copyWith(
    color: AppColors.darkColor,
  );
  static final TextStyle subtitleBold = _subtitleBase.copyWith(
    color: AppColors.label3Color,
    fontWeight: AppFontWeight.bold,
  );
  static final TextStyle subtitleSemiNearWhite = _subtitleBase.copyWith(
    color: AppColors.label1Color,
  );
 static final TextStyle subtitleMed = _subtitleBase.copyWith(
    color: AppColors.label1Color,
   fontWeight: AppFontWeight.medium,
  );
 static final TextStyle subtitleBoldNearWhite = _subtitleBase.copyWith(
    color: AppColors.label1Color,
   fontWeight: AppFontWeight.bold,
  );
 static final TextStyle subtitleMedGrey = _subtitleBase.copyWith(
    color: AppColors.offerBorderText,
   fontWeight: AppFontWeight.medium,
  );
  static final TextStyle subtitleSemiPrime = _subtitleBase.copyWith(
    color: AppColors.primary,
    fontWeight: AppFontWeight.semiBold,
  );

  // ----------------------- Body => 14 ----------------------- //
  // ------ base ------ //
  static final TextStyle _bodyBase = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.semiBold,
  );

  // ------ Styles ------ //
  static final TextStyle bodyMed = _bodyBase.copyWith(
    color: AppColors.nearBlack2TextColor,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle bodyMedBlack3 = _bodyBase.copyWith(
    color: AppColors.black3Color,
    fontWeight: AppFontWeight.medium,
  );


  static final TextStyle bodySemi = _bodyBase.copyWith(
    color: AppColors.deActiveColor,
  );

  static final TextStyle bodyRegPrimary = _bodyBase.copyWith(
    color: AppColors.primary,
    fontWeight: AppFontWeight.regular,
  );
  static final TextStyle bodyBoldPrimary = _bodyBase.copyWith(
    color: AppColors.primary,
    fontWeight: AppFontWeight.bold,
  );

  static final TextStyle bodyRegGrey3 = _bodyBase.copyWith(
    color: AppColors.nearGrey3Color,
    fontWeight: AppFontWeight.regular,
  );
  static final TextStyle bodySemiWhite = _bodyBase.copyWith(
    color: AppColors.white,
  );

  static final TextStyle bodyMedNearBlack = _bodyBase.copyWith(
    color: AppColors.label3Color,
    fontWeight: AppFontWeight.medium
  );
  static final TextStyle bodyBoldNearBlack2 = _bodyBase.copyWith(
    color: AppColors.nearBlack4TextColor,
    fontWeight: AppFontWeight.bold,
  );
  static final TextStyle bodyMedNearGrey = _bodyBase.copyWith(
    color: AppColors.offerBorderText,
  );
  static final TextStyle bodyRegNearBlack = _bodyBase.copyWith(
    color: AppColors.label3Color,
    fontWeight: AppFontWeight.regular
  );
  static final TextStyle bodyRegNearWhite = _bodyBase.copyWith(
    color: AppColors.nearWhite,
    fontWeight: AppFontWeight.regular
  );
  static final TextStyle bodyRegNearBlack2 = _bodyBase.copyWith(
    color: AppColors.nearBlack2TextColor,
    fontWeight: AppFontWeight.regular,
  );
   static final TextStyle bodyRegBlack = _bodyBase.copyWith(
    color: AppColors.black,
    fontWeight: AppFontWeight.regular,
  );
  static final TextStyle bodyMedNearGrey2 = _bodyBase.copyWith(
    color: AppColors.greyTextColor,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle bodySemNearGrey2 = _bodyBase.copyWith(
    color: AppColors.greyTextColor,
    fontWeight: AppFontWeight.semiBold,
  );
  // ----------------------- Caption => 12 ----------------------- //
  // ------ base ------ //
  static final TextStyle _captionBase = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    fontFamily: FontFamily.usedFont,
  );

  // ------ Styles ------ //
  static final TextStyle captionReg = _captionBase.copyWith(
    color: AppColors.greyLightColor,
  );

  static final TextStyle captionRegGrey = _captionBase.copyWith(
    color: AppColors.nearBlack3TextColor,
  );

  static final TextStyle captionRegGery = _captionBase.copyWith(
    color: AppColors.formFieldBorderColor,
  );
  static final TextStyle captionRegDeActive = _captionBase.copyWith(
    color: AppColors.deActiveBarColor,
  );
  static final TextStyle captionRegPrimary = _captionBase.copyWith(
    color: AppColors.primary,
  );
  static final TextStyle captionMedPrimary = _captionBase.copyWith(
    color: AppColors.primary,
    fontWeight: AppFontWeight.medium
  );
  static final TextStyle captionSemiActive = _captionBase.copyWith(
    color: AppColors.activeColor,
    fontWeight: AppFontWeight.semiBold,
  );

  static final TextStyle captionMedActive = _captionBase.copyWith(
    color: AppColors.activeColor,
    fontWeight: AppFontWeight.medium,
  );

  static final TextStyle captionSemiWhite = _captionBase.copyWith(
    color: AppColors.white,
    fontWeight: AppFontWeight.semiBold,
  );
  static final TextStyle captionSemiBlack4 = _captionBase.copyWith(
    color: AppColors.black4Color,
    fontWeight: AppFontWeight.semiBold,
  );
  static final TextStyle captionRegNearGrey = _captionBase.copyWith(
    color: AppColors.offerBorderText,
    fontWeight: AppFontWeight.regular,
  );
  static final TextStyle captionMedNearGrey2 = _captionBase.copyWith(
    color: AppColors.greyTextColor,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle captionRegNearGrey2 = _captionBase.copyWith(
    color: AppColors.greyTextColor,
    fontWeight: AppFontWeight.regular,
  );

  static final TextStyle captionMedNearBlack = _captionBase.copyWith(
    color: AppColors.label3Color,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle captionMeActive2 = _captionBase.copyWith(
    color: AppColors.active2Text,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle captionSemiActive2 = _captionBase.copyWith(
    color: AppColors.active2Text,
    fontWeight: AppFontWeight.semiBold,
  );

  static final TextStyle captionMedProfile = _captionBase.copyWith(
    color: AppColors.nearBlack2TextColor,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle captionMedAuth = _captionBase.copyWith(
    color: AppColors.offerTimeText,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle captionSemiInfo = _captionBase.copyWith(
    color: AppColors.nearBlack2TextColor,
    fontWeight: AppFontWeight.semiBold,
  );
  static final TextStyle captionRegCode = _captionBase.copyWith(
    color: AppColors.nearBlack2TextColor,
    fontWeight: AppFontWeight.regular,
  );

  static final TextStyle captionBoldGrey = _captionBase.copyWith(
    color: AppColors.border2Color,
    fontWeight: AppFontWeight.bold,
  );

  // ----------------------- Label => 10 ----------------------- //
  static final TextStyle _labelBase = TextStyle(
    fontSize: 10,
    fontWeight: AppFontWeight.regular,
  );

  // ------ Styles ------ //
  static final TextStyle labelReg = _labelBase.copyWith(
    color: AppColors.offerTimeText,
  );
  static final TextStyle labelRegNearBlack = _labelBase.copyWith(
    color: AppColors.label3Color,
  );
  static final TextStyle labelSemi = _labelBase.copyWith(
    color: AppColors.white,
    fontWeight: AppFontWeight.semiBold,
  );
  static final TextStyle labelMed = _labelBase.copyWith(
    color: AppColors.nearBlackTextColor,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle labelMedNearBlack = _labelBase.copyWith(
    color: AppColors.black3Color,
    fontWeight: AppFontWeight.medium,
  );
  static final TextStyle labelSemiNearWhite = _labelBase.copyWith(
    color: AppColors.smallBoxColor,
    fontWeight: AppFontWeight.semiBold,
  );

  // ----------------------- Caption => 12 ----------------------- //
  // ----------------------- Caption => 12 ----------------------- //
  // ----------------------- Caption => 12 ----------------------- //
  // ----------------------- Caption => 12 ----------------------- //
  // ----------------------- Caption => 12 ----------------------- //
  // ----------------------- Caption => 12 ----------------------- //

  static TextStyle label41DeActive = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.deActiveColor,
  );

  // ----------------------- HeadLines ----------------------- //
  static TextStyle headLine3 = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.deActiveColor,
  );

  // ----------------------- Labels ----------------------- //
  // ----------------------- Labels ----------------------- //
  // ----------------------- Labels ----------------------- //
  // ----------------------- Others ----------------------- //
  // button
  static TextStyle buttonTextStyle = TextStyle(
    color: AppColors.background,
    fontSize: 16,
    fontWeight: AppFontWeight.semiBold,
  );
  // textField
  static TextStyle textFieldTextStyle = TextStyle(
    color: AppColors.nearBlack2TextColor,
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    fontFamily: FontFamily.balooBhaijaan,
  );
  // hint
  static TextStyle hintTextStyle = TextStyle(
    color: AppColors.grey2Color,
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    fontFamily: FontFamily.balooBhaijaan,
  );

  // selectCountry
  static TextStyle selectCountryTextStyle = TextStyle(
    color: AppColors.selectCountryColor,
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
  );
  static TextStyle pinCodeTextStyle = TextStyle(
    color: AppColors.nearBlack2TextColor,
    fontSize: 20,
    fontWeight: AppFontWeight.medium,
  );

  // ----------------------- Labels ----------------------- //
  static TextStyle label1SemiBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.label1Color,
  );

  static TextStyle label1Black = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.nearBlack2TextColor,
  );

  static TextStyle label2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300, // Light
    color: AppColors.label2Color,
  );

  static TextStyle label3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.label3Color,
  );
  static TextStyle label3greyLight = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.greyLightColor,
  );

  static TextStyle label312 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.label3Color,
  );

  static TextStyle label3Bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.label3Color,
  );

  static TextStyle label3SemiBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.label3Color,
  );

  // ============================================================================
  // GREY TEXT
  // ============================================================================

  static TextStyle headGrey = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.greyTextColor,
  );

  static TextStyle label3Grey = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.greyTextColor,
  );

  static TextStyle label1Med = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.nearGreyColor,
  );

  static TextStyle labelMed12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.label3Color,
  );

  // ============================================================================
  // ACTIVE/SUCCESS
  // ============================================================================

  static TextStyle label2Active = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.activeText,
  );

  static TextStyle label1Active = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.activeColor,
  );

  static TextStyle label1ActiveSemi = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.activeColor,
  );

  // ============================================================================
  // NEAR BLACK
  // ============================================================================

  static TextStyle label1NearBlack = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.nearBlack2TextColor,
  );

  static TextStyle label1NearBlack14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.nearBlack2TextColor,
  );

  // ============================================================================
  // OFFER/COUPON
  // ============================================================================

  static TextStyle label1Offer = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.offerBorderText,
  );

  static TextStyle label1OfferMed = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.offerBorderText,
  );

  static TextStyle label1Time = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.offerTimeText,
  );

  // ============================================================================
  // DEACTIVE/DISABLED
  // ============================================================================

  static TextStyle label1DeActive = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.deActiveColor,
  );

  // ============================================================================
  // HEADLINES
  // ============================================================================

  static TextStyle headLine2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.nearBlackTextColor,
  );

  static TextStyle headLine4 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.deActiveBarColor,
  );

  static TextStyle headLineActive = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.active2Text,
  );

  static TextStyle headLine3Offer = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  // ============================================================================
  // PRIMARY COLOR
  // ============================================================================

  static TextStyle headLine12Primary = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle label2Primary = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static TextStyle label2PrimaryMed = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  // ============================================================================
  // REGULAR
  // ============================================================================

  static TextStyle label12reg = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.label1Color,
  );

  static TextStyle activeBar = TextStyle(
    color: AppColors.primary,
    fontSize: 12,
  );

  static TextStyle deActiveBar = TextStyle(
    color: AppColors.deActiveBarColor,
    fontSize: 12,
  );
}
