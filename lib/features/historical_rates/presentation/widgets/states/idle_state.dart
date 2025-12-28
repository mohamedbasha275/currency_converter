import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:currency_converter/features/currency_list/presentation/screens/currency_list_screen.dart';
import 'package:currency_converter/features/historical_rates/presentation/manager/historical_rates_cubit.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/components/page_header.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/currency_pickers_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdleState extends StatelessWidget {
  final String from;
  final String to;
  final VoidCallback onShow;

  const IdleState({
    super.key,
    required this.from,
    required this.to,
    required this.onShow,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoricalRatesCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(),
          CurrencyPickersRow(
            fromCode: from,
            toCode: to,
            onFromTap: () => _pickCurrency(
              context,
              (c) {
                if (c != null) cubit.setCurrencies(c.code, to);
              },
            ),
            onToTap: () => _pickCurrency(
              context,
              (c) {
                if (c != null) cubit.setCurrencies(from, c.code);
              },
            ),
            onSwap: () => cubit.setCurrencies(to, from),
          ),
          32.heightBox,
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12),
              ),
              onPressed: onShow,
              icon: Icon(Icons.search,color: AppColors.iconColor),
              label: AppText('Show Results',style: AppTextStyles.highlightWhiteMed),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickCurrency(
    BuildContext context,
    ValueChanged<CurrencyListEntity?> onSelected,
  ) async {
    final selected = await showModalBottomSheet<CurrencyListEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.8,
        child: CurrencyListScreen(asBottomSheet: true),
      ),
    );

    if (context.mounted) {
      onSelected(selected);
    }
  }
}



