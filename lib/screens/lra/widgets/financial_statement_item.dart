import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/theme_color.dart';
import '../../../extensions/double_extension.dart';
import '../../../podo/financial_statement.dart';
import '../lra_cubit.dart';

class FinancialStatementItem extends StatelessWidget {
  final FinancialStatement financialStatement;
  const FinancialStatementItem({super.key, required this.financialStatement});

  @override
  Widget build(BuildContext context) {
    final selectedLevel = context.select<LraCubit, Level>((value) => value.state.level);
    final level = financialStatement.level;

    if (level > selectedLevel) return Container();
    return Container(
      padding: EdgeInsets.only(left: 20.0 * (level.index - 1), top: 8),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: ThemeColor.level4,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  Expanded(
                    child: Text(
                      "${financialStatement.accountName} (${financialStatement.accountCode})",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 20),
                  Expanded(
                    child: Text(
                        "${financialStatement.realization.thousandSeparated} / ${financialStatement.budgetOrTarget.thousandSeparated}"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
