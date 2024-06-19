import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../podo/financial_statement.dart';
import '../../widgets/common_bottom_navigation_bar.dart';
import 'lra_cubit.dart';
import 'lra_state.dart';
import 'widgets/filter_lra.dart';
import 'widgets/financial_statement_item.dart';

class LraScreen extends StatelessWidget {
  const LraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FilterLra(),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Expanded(
                    child: BlocSelector<LraCubit, LraState, List<FinancialStatement>>(
                      selector: (state) => state.financialStatements,
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: state.length,
                          itemBuilder: (context, index) {
                            final financialStatement = state[index];
                            print('state');
                            print(state.length);
                            return FinancialStatementItem(financialStatement: financialStatement);
                          },
                          
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CommonBottomNavigationBar(),
        ],
      ),
    );
  }
}
