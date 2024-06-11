import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../podo/budgetary_stage.dart';
import '../../../../podo/department.dart';
import '../../../../podo/financial_statement.dart';
import '../../../../widgets/common_dropdown.dart';
import 'filter_lra_form_cubit.dart';
import 'filter_lra_form_state.dart';

class FilterLraForm extends StatelessWidget {
  const FilterLraForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jenis Anggaran",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: double.infinity,
                      child:
                          BlocBuilder<FilterLraFormCubit, FilterLraFormState>(
                        buildWhen: (previous, current) {
                          final eq = const UnorderedIterableEquality().equals;
                          return previous.budgetaryStage !=
                                  current.budgetaryStage ||
                              !eq(previous.budgetaryStages,
                                  current.budgetaryStages);
                        },
                        builder: (context, state) {
                          return CommonDropdown<BudgetaryStage?>(
                            value: state.budgetaryStage,
                            items: state.budgetaryStages,
                            onChanged: (budgetaryStage) {
                              context
                                  .read<FilterLraFormCubit>()
                                  .setBudgetaryStage(budgetaryStage);
                            },
                            isExpanded: true,
                          );
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    Text("SKPD",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: double.infinity,
                      child:
                          BlocBuilder<FilterLraFormCubit, FilterLraFormState>(
                        buildWhen: (previous, current) {
                          final eq = const UnorderedIterableEquality().equals;
                          return previous.department != current.department ||
                              !eq(previous.departments, current.departments);
                        },
                        builder: (context, state) {
                          return CommonDropdown<Department?>(
                            value: state.department,
                            items: state.departments,
                            onChanged: (department) {
                              context
                                  .read<FilterLraFormCubit>()
                                  .setDepartment(department);
                            },
                            isExpanded: true,
                          );
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    Text("Tingkat Rekening",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: double.infinity,
                      child:
                          BlocBuilder<FilterLraFormCubit, FilterLraFormState>(
                        buildWhen: (previous, current) {
                          final eq = const UnorderedIterableEquality().equals;
                          return previous.level != current.level ||
                              !eq(previous.levels, current.levels);
                        },
                        builder: (context, state) {
                          return CommonDropdown<Level>(
                            value: state.level,
                            items: state.levels,
                            onChanged: (level) {
                              if (level == null) return;
                              context
                                  .read<FilterLraFormCubit>()
                                  .setLevel(level);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                onPressed: () {
                  final state = context.read<FilterLraFormCubit>().state;
                  final budgetaryStage = state.budgetaryStage;

                  if (budgetaryStage == null) return;

                  final modalData = FilterModalData(
                    year: state.year,
                    level: state.level,
                    department: state.department,
                    budgetaryStage: budgetaryStage,
                  );
                  context.pop(modalData);
                },
                child: const Text("Apply"),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FilterModalData {
  int year;
  Department? department;
  Level level;
  BudgetaryStage budgetaryStage;

  FilterModalData(
      {required this.year,
      required this.level,
      this.department,
      required this.budgetaryStage});
}
