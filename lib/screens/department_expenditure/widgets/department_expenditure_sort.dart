import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_switch.dart';
import '../department_expenditure_cubit.dart';
import '../department_expenditure_state.dart';
import '../order.dart';

class DepartmentExpenditureSort extends StatelessWidget {
  const DepartmentExpenditureSort({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sort By", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocSelector<DepartmentExpenditureCubit, DepartmentExpenditureState, OrderColumn>(
                  selector: (state) => state.order.column,
                  builder: (context, state) {
                    return CommonDropdown(
                      value: state,
                      items: OrderColumn.values,
                      onChanged: (value) {
                        if (value == null) return;
                        context.read<DepartmentExpenditureCubit>().setOrderColumn(value);
                      },
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.only(left: 8)),
                BlocSelector<DepartmentExpenditureCubit, DepartmentExpenditureState, OrderType>(
                  selector: (state) => state.order.type,
                  builder: (context, state) {
                    return CommonSwitch(
                      a: OrderType.asc,
                      b: OrderType.desc,
                      selectedValue: state,
                      reversed: true,
                      onChanged: (value) {
                        context.read<DepartmentExpenditureCubit>().setOrderType(value);
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
