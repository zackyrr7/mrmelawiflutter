import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/theme_color.dart';

class CommonDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final void Function(T? value) onChanged;
  final bool isExpanded;
  const CommonDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.level4, width: 1.5),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isDense: true,
          value: value,
          items: [
            for (final item in items)
              DropdownMenuItem(
                value: item,
                child: Text(item.toString(), style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
              ),
          ],
          isExpanded: isExpanded,
          onChanged: onChanged,
          underline: null,
        ),
      ),
    );
  }
}
