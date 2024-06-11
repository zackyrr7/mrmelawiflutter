import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/common_dropdown.dart';
import '../department_expenditure_cubit.dart';
import '../department_expenditure_state.dart';

class DepartmentExpenditureFilter extends StatelessWidget {
  const DepartmentExpenditureFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Filter By", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<DepartmentExpenditureCubit, DepartmentExpenditureState>(
                  buildWhen: (previous, current) {
                    final eq = const UnorderedIterableEquality().equals;
                    return previous.budgetaryStage != current.budgetaryStage ||
                        !eq(previous.budgetaryStages, current.budgetaryStages);
                  },
                  builder: (context, state) {
                    return CommonDropdown(
                      value: state.budgetaryStage,
                      items: state.budgetaryStages,
                      onChanged: (value) {
                        if (value == null) return;
                        context.read<DepartmentExpenditureCubit>().setBudgetaryStage(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
