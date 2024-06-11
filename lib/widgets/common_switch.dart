import 'package:flutter/material.dart';

import '../constants/theme_color.dart';
import 'common_builder.dart';

class CommonSwitch<T> extends StatelessWidget {
  final T a;
  final T b;
  final T selectedValue;
  final void Function(T value) onChanged;
  final bool reversed;
  final double minWidth;
  final bool isExpanded;
  const CommonSwitch({
    super.key,
    required this.a,
    required this.b,
    required this.selectedValue,
    required this.onChanged,
    this.reversed = false,
    this.minWidth = 64,
    this.isExpanded = false,
  });

  Color get activeBackgroundColor => reversed ? Colors.white : ThemeColor.level4;

  Color get activeTextColor => reversed ? Colors.black : Colors.white;
  Color get inactiveTextColor => reversed ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: reversed ? ThemeColor.level4 : Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonBuilder(
            builder: (context, child) {
              if (isExpanded) return Expanded(child: child);

              return child;
            },
            child: Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(32),
              color: selectedValue == a ? activeBackgroundColor : Colors.transparent,
              child: InkWell(
                onTap: () {
                  onChanged(a);
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: minWidth),
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    a.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedValue == a ? activeTextColor : inactiveTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 4)),
          CommonBuilder(
            builder: (context, child) {
              if (isExpanded) return Expanded(child: child);

              return child;
            },
            child: Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(32),
              color: selectedValue == b ? activeBackgroundColor : Colors.transparent,
              child: InkWell(
                onTap: () {
                  onChanged(b);
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: minWidth),
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    b.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedValue == b ? activeTextColor : inactiveTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
