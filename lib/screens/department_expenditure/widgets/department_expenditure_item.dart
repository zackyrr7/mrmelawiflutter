import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extensions/double_extension.dart';
import '../../../podo/department_expenditure.dart';

class DepartmentExpenditureItem extends StatelessWidget {
  final DepartmentExpenditure departmentExpenditure;
  const DepartmentExpenditureItem({super.key, required this.departmentExpenditure});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(departmentExpenditure.department.code, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            Text(departmentExpenditure.department.name),
            const Padding(padding: EdgeInsets.only(top: 12)),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Anggaran", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      Text(departmentExpenditure.budget.thousandSeparated),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Realisasi", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      Text(departmentExpenditure.realization.thousandSeparated),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
