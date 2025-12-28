import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class  CurrencyFlag extends StatelessWidget {
  final String url;
  final double size;
  const  CurrencyFlag({super.key, required this.url, this.size=44});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl:url,
        width: size,
        height: size,
        memCacheWidth: 100,
        fit: BoxFit.cover,
        memCacheHeight: 100,
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        placeholder: (_, __) =>
            Icon(Icons.flag_circle, color: AppColors.primary2,size: 35),
        errorWidget: (_, __, ___) =>
            Icon(Icons.flag_circle, color: AppColors.primary2,size: 35),
      ),
    );
  }
}
