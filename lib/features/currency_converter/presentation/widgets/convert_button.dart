import 'package:currency_converter/common/custom_button.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  final CurrencyConverterCubit cubit;
  final CurrencyConverterState state;

  const ConvertButton({super.key, required this.cubit, required this.state});

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: CustomButton(
        onPressed: cubit.amount > 0 ? cubit.convertCurrency : null,
        child: state is CurrencyConverterLoading
            ? SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.iconColor),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sync, color: AppColors.iconColor, size: 20),
            8.widthBox,
            AppText(
              'Convert Now',
              style: AppTextStyles.highlightWhiteSemi,
            ),
          ],
        )
      ),
    );
  }
}
