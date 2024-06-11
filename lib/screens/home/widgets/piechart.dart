import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../extensions/double_extension.dart';
import '../../../widgets/common_dropdown.dart';
import '../chart_data.dart';
import '../home_cubit.dart';
import '../home_state.dart';
import '../types/account_type.dart';

class PieChart extends StatelessWidget {
  const PieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select<HomeCubit, List<ChartData>>((value) => value.state.chartData);
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8),
            child: BlocSelector<HomeCubit, HomeState, AccountType>(
              selector: (state) => state.accountType,
              builder: (context, state) {
                return CommonDropdown(
                  value: state,
                  items: AccountType.values,
                  onChanged: (accountType) {
                    if (accountType == null) return;
                    context.read<HomeCubit>().setAccountType(accountType);
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Builder(
              builder: (context) {
                if (state.isEmpty) return const Center(child: Text("No Data Available"));
                return SfCircularChart(
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                      dataSource: state,
                      pointColorMapper: (datum, index) {
                        return datum.color;
                      },
                      xValueMapper: (datum, index) => datum.financialStatement.accountName,
                      yValueMapper: (datum, index) => datum.yValue,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        textStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      dataLabelMapper: (datum, index) {
                        return datum.yValue.thousandSeparated;
                      },
                      explode: true,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
