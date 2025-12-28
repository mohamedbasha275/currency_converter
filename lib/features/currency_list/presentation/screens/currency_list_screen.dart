import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:currency_converter/features/currency_list/presentation/manager/currency_list_cubit.dart';
import 'package:currency_converter/features/currency_list/presentation/widgets/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CurrencyListScreen extends HookWidget {
  final ValueChanged<CurrencyListEntity>? onCurrencySelected;
  final CurrencyListEntity? selectedCurrency;
  final bool asBottomSheet;

  const CurrencyListScreen({
    super.key,
    this.onCurrencySelected,
    this.selectedCurrency,
    this.asBottomSheet = false,
  });

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    // Clear search when modal is opened
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CurrencyListCubit>().clearSearch();
      });
      return null;
    }, []);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.heightBox,
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: AppText('Select Currency',
                      style: AppTextStyles.highlightBlackSemi),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          Flexible(
            child: BlocBuilder<CurrencyListCubit, CurrencyListState>(
              builder: (context, state) {
                if (state is CurrencyListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CurrencyListError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${state.message}'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CurrencyListCubit>().getCurrencies();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is CurrencyListLoaded) {
                  return SizedBox(
                    height: context.screenHeight,
                    child: Column(
                      children: [
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: TextFormField(
                            controller: searchController,
                            onChanged: (value) {
                              context
                                  .read<CurrencyListCubit>()
                                  .searchCurrencies(value);
                            },
                            decoration: InputDecoration(
                              hintText: 'Search code or country',
                              hintStyle:
                                  TextStyle(color: AppColors.nearBlueGrey),
                              prefixIcon:
                                  Icon(Icons.search, color: AppColors.nearBlueGrey),
                              suffixIcon: searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear,
                                          color: AppColors.nearBlueGrey),
                                      onPressed: () {
                                        searchController.clear();
                                        context
                                            .read<CurrencyListCubit>()
                                            .clearSearch();
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
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: state.hasResults
                              ? ListView.builder(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 12, 16, 16),
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  itemCount: state.filteredCurrencies.length,
                                  itemBuilder: (context, index) {
                                    return CurrencyItem(
                                      currency: state.filteredCurrencies[index],
                                      onTap: () {
                                        onCurrencySelected?.call(
                                            state.filteredCurrencies[index]);
                                        Navigator.of(context).pop(
                                            state.filteredCurrencies[index]);
                                      },
                                    );
                                  },
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off_rounded,
                                        size: 80,
                                        color: AppColors.nearBlueGrey
                                            .withValues(alpha: 0.3),
                                      ),
                                      16.heightBox,
                                      AppText(
                                        'No currencies found',
                                        style: AppTextStyles.highlightBlackSemi,
                                      ),
                                      8.heightBox,
                                      AppText(
                                        'Try searching with different keywords',
                                        style: AppTextStyles.bodyMedBlueGrey,
                                      ),
                                      if (searchController.text.isNotEmpty) ...[
                                        20.heightBox,
                                        TextButton.icon(
                                          onPressed: () {
                                            searchController.clear();
                                            context
                                                .read<CurrencyListCubit>()
                                                .clearSearch();
                                          },
                                          icon: Icon(Icons.clear,
                                              color: AppColors.primary),
                                          label: AppText(
                                            'Clear Search',
                                            style: AppTextStyles.bodyMedBlueGrey
                                                .copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
