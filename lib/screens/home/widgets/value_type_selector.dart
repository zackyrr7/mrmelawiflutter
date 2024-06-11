import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/common_switch.dart';
import '../home_cubit.dart';
import '../types/value_type.dart';

class ValueTypeSelector extends StatelessWidget {
  const ValueTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select<HomeCubit, ValueType>((value) => value.state.valueType);
    return CommonSwitch(
      a: ValueType.anggaran,
      b: ValueType.realisasi,
      selectedValue: state,
      onChanged: (value) {
        context.read<HomeCubit>().setValueType(value);
      },
      isExpanded: true,
    );
  }
}
