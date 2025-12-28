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

class LoadingState extends StatelessWidget {
  final String from;
  final String to;

  const LoadingState({
    super.key,
    required this.from,
    required this.to,
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
          60.heightBox,
          Center(
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary,
                ),
                16.heightBox,
                AppText(
                  'Loading historical rates...',
                  style: AppTextStyles.highlightBlackReg,
                ),
              ],
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
        heightFactor: 0.7,
        child: CurrencyListScreen(asBottomSheet: true),
      ),
    );

    if (context.mounted) {
      onSelected(selected);
    }
  }
}

