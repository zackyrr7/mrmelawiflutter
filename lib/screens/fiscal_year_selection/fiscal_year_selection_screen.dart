import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/shared_cubit.dart';
import '../../blocs/shared_state.dart';
import '../../routes.dart';
import '../../widgets/common_dropdown.dart';
import 'fiscal_year_selection_cubit.dart';
import 'fiscal_year_selection_state.dart';

class FiscalYearSelectionScreen extends StatelessWidget {
  const FiscalYearSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<FiscalYearSelectionCubit, FiscalYearSelectionState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingFiscalYear) {
              return const CircularProgressIndicator();
            } else if (state is FiscalYearLoaded) {
              return Column(
                children: [
                  BlocSelector<SharedCubit, SharedState, int?>(
                    selector: (state) => state.selectedYear,
                    builder: (context, selectedYear) {
                      return CommonDropdown(
                        value: selectedYear,
                        items: state.years,
                        onChanged: (year) {
                          if (year == null) return;
                          context.read<SharedCubit>().setYear(year);
                        },
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  ElevatedButton(
                    onPressed: () {
                      context.push(AppRoute.home);
                    },
                    child: const Text("LANJUT"),
                  ),
                ],
              );
            } else if (state is ErrorLoadingFiscalYear) {
              return Column(
                children: [
                  Text(state.errorMessage, textAlign: TextAlign.center),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FiscalYearSelectionCubit>().fetchYears();
                    },
                    child: const Text("Reload"),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
