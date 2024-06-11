import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/theme_color.dart';
import '../../podo/department_expenditure.dart';
import '../../widgets/common_bottom_navigation_bar.dart';
import 'department_expenditure_cubit.dart';
import 'department_expenditure_state.dart';
import 'widgets/department_expenditure_filter.dart';
import 'widgets/department_expenditure_item.dart';
import 'widgets/department_expenditure_sort.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.level3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              "Realisasi Belanja SKPD",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: DepartmentExpenditureFilter(),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: DepartmentExpenditureSort(),
          ),
          const Padding(padding: EdgeInsets.only(top: 12)),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
                child:
                    BlocSelector<DepartmentExpenditureCubit, DepartmentExpenditureState, List<DepartmentExpenditure>>(
                  selector: (state) => state.orderedDepartmentExpenditure,
                  builder: (context, state) {
                    return Column(
                      children: [
                        for (final department in state)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: DepartmentExpenditureItem(departmentExpenditure: department),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          const CommonBottomNavigationBar(),
        ],
      ),
    );
  }
}
