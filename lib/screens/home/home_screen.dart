import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/shared_cubit.dart';
import '../../blocs/shared_state.dart';
import '../../constants/theme_color.dart';
import '../../widgets/common_bottom_navigation_bar.dart';
import 'home_cubit.dart';
import 'home_state.dart';
import 'widgets/home_filter.dart';
import 'widgets/piechart.dart';
import 'widgets/piechart_legend.dart';
import 'widgets/value_type_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: ThemeColor.level3,
                    padding: const EdgeInsets.only(top: 24, bottom: 16, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocSelector<SharedCubit, SharedState, int?>(
                          selector: (state) => state.selectedYear,
                          builder: (context, year) {
                            return Text(
                              "APBD Melawi $year",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            );
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(top: 24)),
                        const HomeFilter(),
                        const Padding(padding: EdgeInsets.only(top: 16)),
                        Container(
                          alignment: Alignment.centerRight,
                          child: BlocSelector<HomeCubit, HomeState, DateTime?>(
                            selector: (state) => state.lastUpdate,
                            builder: (context, state) {
                              if (state == null) return const Text("");

                              return Text(
                                state.toString(),
                                style: const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 16)),
                        const PieChart(),
                        const Padding(padding: EdgeInsets.only(top: 16)),
                        const ValueTypeSelector(),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: const PieChartLegend(),
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
