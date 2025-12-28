import 'package:currency_converter/common/animations/app_animations.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_assets.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/converter_card.dart';
import 'package:currency_converter/features/currency_list/presentation/screens/currency_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CurrencyConverterScreen extends HookWidget {
  const CurrencyConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurrencyConverterCubit>();
    
    // استخدم hook controller (بيعمل dispose automatically)
    final amountController = useTextEditingController();
    
    // حدّث القيمة من الـ cubit - بنستخدم cubit.amount كـ key
    final currentAmount = cubit.amount;
    
    useEffect(() {
      // حدّث الـ text controller بالقيمة الجديدة
      amountController.text = currentAmount.toString();
      return null;
    }, [currentAmount]);

    Future pickCurrency() {
      return showAnimatedBottomSheet(
        context: context,
        child:  FractionallySizedBox(
          heightFactor: 0.80,
          child: CurrencyListScreen(asBottomSheet: true),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppText(
                   'Welcome',
                    style: AppTextStyles.titleMedBlack,
                  ),
                  8.widthBox,
                   Icon(
                    CupertinoIcons.money_dollar_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ],
              ),
              Image.asset(
                ImageAssets.logo,
                width: 150,
              ),
            ],
          ),
          10.heightBox,
          ConverterCard(
            amountController: amountController,
            onPickFromCurrency: () async {
              final selected = await pickCurrency();
              if (!context.mounted || selected == null) return;
              context.read<CurrencyConverterCubit>().setFromCurrency(selected);
            },
            onPickToCurrency: () async {
              final selected = await pickCurrency();
              if (!context.mounted || selected == null) return;
              context.read<CurrencyConverterCubit>().setToCurrency(selected);
            },
          ),
          20.heightBox,
        ],
      ),
    );
  }
}
