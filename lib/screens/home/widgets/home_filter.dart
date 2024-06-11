import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/common_dropdown.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class HomeFilter extends StatelessWidget {
  const HomeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) {
                final eq = const UnorderedIterableEquality().equals;
                return previous.budgetaryStage != current.budgetaryStage ||
                    !eq(previous.budgetaryStages, current.budgetaryStages);
              },
              builder: (context, state) {
                return CommonDropdown(
                  value: state.budgetaryStage,
                  items: state.budgetaryStages,
                  onChanged: (budgetaryStage) {
                    if (budgetaryStage == null) return;
                    context.read<HomeCubit>().setBudgetaryStage(budgetaryStage);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
