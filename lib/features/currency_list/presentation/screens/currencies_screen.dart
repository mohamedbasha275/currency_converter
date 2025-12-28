import 'package:currency_converter/app_widgets/empty_widget.dart';
import 'package:currency_converter/app_widgets/error_widget.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_list/presentation/manager/currency_list_cubit.dart';
import 'package:currency_converter/features/currency_list/presentation/widgets/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CurrenciesScreen extends HookWidget {
  const CurrenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final isRefreshing = useState(false);

    // Clear search when screen is opened
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CurrencyListCubit>().clearSearch();
      });
      return null;
    }, []);

    void handleRefresh() async {
      isRefreshing.value = true;
      searchController.clear();
      await context.read<CurrencyListCubit>().refreshCurrencies();
      
      isRefreshing.value = false;
      
      final state = context.read<CurrencyListCubit>().state;
      if (state is CurrencyListLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✓ ${state.currencies.length} currencies updated'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.activeBadge,
          ),
        );
      } else if (state is CurrencyListError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to refresh: ${state.message}'),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText('Currencies', style: AppTextStyles.displayBlackBold),
                        AppText('Browse supported currency codes', style: AppTextStyles.titleMedGrey),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: isRefreshing.value ? null : handleRefresh,
                    icon: isRefreshing.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.primary,
                            ),
                          )
                        : Icon(
                            Icons.refresh_rounded,
                            color: AppColors.primary,
                            size: 28,
                          ),
                    tooltip: 'Refresh currencies from server',
                  ),
                ],
              ),
              24.heightBox,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            controller: searchController,
            onChanged: (value) {
              context.read<CurrencyListCubit>().searchCurrencies(value);
            },
            decoration: InputDecoration(
              hintText: 'Search code or country',
              hintStyle: TextStyle(color: AppColors.nearBlueGrey),
              prefixIcon: Icon(Icons.search, color: AppColors.nearBlueGrey),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: AppColors.nearBlueGrey),
                      onPressed: () {
                        searchController.clear();
                        context.read<CurrencyListCubit>().clearSearch();
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppColors.convertCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.cardBorder,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: BlocBuilder<CurrencyListCubit, CurrencyListState>(
            builder: (context, state) {
              if (state is CurrencyListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CurrencyListError) {
                return AppErrorWidget(
                  message: state.message,
                  function: () => context
                      .read<CurrencyListCubit>()
                      .getCurrencies(),
                );
              }
              if (state is! CurrencyListLoaded) {
                return const SizedBox.shrink();
              }

              return state.hasResults
                  ? ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.filteredCurrencies.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) {
                        final c = state.filteredCurrencies[i];
                        return CurrencyItem(currency: c, onTap: () {});
                      },
                    )
                  : AppEmptyWidget(
                      message: 'No currencies found for your search.',
                    );
            },
          ),
        ),
      ],
    );
  }
}
