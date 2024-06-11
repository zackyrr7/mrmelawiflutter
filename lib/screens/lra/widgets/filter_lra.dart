import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../podo/financial_statement.dart';
import '../lra_cubit.dart';
import 'filter_lra_form/filter_lra_form.dart';
import 'filter_lra_form/filter_lra_form_cubit.dart';
import 'filter_lra_form/filter_lra_form_state.dart';
import 'lra_applied_filter.dart';

class FilterLra extends StatelessWidget {
  const FilterLra({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: LraAppliedFilter()),
        InkWell(
          onTap: () {
            final state = context.read<LraCubit>().state;
            showModalBottomSheet<FilterModalData>(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) {
                    final initialState = FilterLraFormState(
                      year: state.year,
                      level: state.level,
                      levels: Level.values,
                      department: state.department,
                      budgetaryStage: state.budgetaryStage,
                    );
                    return FilterLraFormCubit(initialState);
                  },
                  child: const FilterLraForm(),
                );
              },
            ).then((filterModalData) {
              if (filterModalData == null) return;
              context.read<LraCubit>().applyFilter(
                    level: filterModalData.level,
                    department: filterModalData.department,
                    budgetaryStage: filterModalData.budgetaryStage,
                  );
            });
          },
          child: const Icon(Icons.filter_alt_outlined),
        ),
      ],
    );
  }
}
