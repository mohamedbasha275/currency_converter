import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:currency_converter/features/currency_list/presentation/screens/currency_list_screen.dart';
import 'package:currency_converter/features/historical_rates/presentation/manager/historical_rates_cubit.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/currency_pickers_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencySection extends StatelessWidget {
  final String from;
  final String to;

  const CurrencySection({
    super.key,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoricalRatesCubit>();

    return CurrencyPickersRow(
      fromCode: from,
      toCode: to,
      onFromTap: () => _pickCurrency(
        context,
        (c) => cubit.setCurrencies(c.code, to),
      ),
      onToTap: () => _pickCurrency(
        context,
        (c) => cubit.setCurrencies(from, c.code),
      ),
      onSwap: () => cubit.setCurrencies(to, from),
    );
  }

  Future<void> _pickCurrency(
    BuildContext context,
    ValueChanged<CurrencyListEntity> onSelected,
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

    if (context.mounted && selected != null) {
      onSelected(selected);
    }
  }
}



