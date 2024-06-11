import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../podo/budgetary_stage.dart';
import '../../../podo/department.dart';
import '../../../podo/financial_statement.dart';
import '../lra_cubit.dart';
import '../lra_state.dart';

class LraAppliedFilter extends StatelessWidget {
  const LraAppliedFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        BlocSelector<LraCubit, LraState, int>(
          selector: (state) => state.year,
          builder: (context, state) {
            return Chip(label: Text("$state"));
          },
        ),
        BlocSelector<LraCubit, LraState, BudgetaryStage?>(
          selector: (state) => state.budgetaryStage,
          builder: (context, state) {
            if (state == null) return Container();

            return Chip(label: Text(state.name));
          },
        ),
        BlocSelector<LraCubit, LraState, Level>(
          selector: (state) => state.level,
          builder: (context, state) {
            return Chip(label: Text("$state"));
          },
        ),
        BlocSelector<LraCubit, LraState, Department?>(
          selector: (state) => state.department,
          builder: (context, state) {
            if (state == null) return Container();

            return Chip(
              label: Text(state.name),
              onDeleted: () {
                context.read<LraCubit>().setDepartment(null);
              },
            );
          },
        ),
      ],
    );
  }
}
