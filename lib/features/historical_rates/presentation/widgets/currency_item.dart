import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:flutter/material.dart';

class  CurrencyItem extends StatelessWidget {
  final CurrencyListEntity currency;

  const  CurrencyItem({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: currency.flagUrl,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) =>
              const SizedBox(width: 44, height: 44),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currency.code,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0B1220),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currency.name,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7C8AA5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFB6C0D3),
          ),
        ],
      ),
    );
  }
}
