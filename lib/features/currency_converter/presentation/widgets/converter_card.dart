import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/features/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/amount_input_field.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/convert_button.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/currency_select_tile.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/result_card.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/swap_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterCard extends StatelessWidget {
  final TextEditingController amountController;
  final Future<void> Function() onPickFromCurrency;
  final Future<void> Function() onPickToCurrency;

  const ConverterCard({
    super.key,
    required this.amountController,
    required this.onPickFromCurrency,
    required this.onPickToCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyConverterCubit, CurrencyConverterState>(
      builder: (context, state) {
        final cubit = context.read<CurrencyConverterCubit>();
        final from = cubit.fromCurrency;
        final to = cubit.toCurrency;
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        AmountInputField(
                          controller: amountController,
                          onChanged: (value) {
                            cubit.setAmount(double.tryParse(value) ?? 0.0);
                          },
                        ),
                        16.heightBox,
                        CurrencySelectTile(
                          label: 'From',
                          currency: from!,
                          onTap: () async => onPickFromCurrency(),
                        ),
                        24.heightBox,
                        CurrencySelectTile(
                          label: 'To',
                          currency: to!,
                          onTap: () async => onPickToCurrency(),
                        ),
                        16.heightBox,
                        ConvertButton(cubit: cubit, state: state),
                      ],
                    ),
                    SwapButton(onTap: cubit.swapCurrencies),
                  ],
                ),
              ),
            ),
            10.heightBox,
            ResultCard(
              from: from,
              to: to,
              exchangeRate: cubit.exchangeRate,
              convertedAmount: cubit.convertedAmount,
            ),
          ],
        );
      },
    );
  }
}
