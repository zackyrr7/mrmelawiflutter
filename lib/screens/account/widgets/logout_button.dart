import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/theme_color.dart';
import '../blocs/account_bloc/account_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Material(
        color: ThemeColor.level4,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: InkWell(
          onTap: () {
            context.read<AccountCubit>().logout();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text("LOGOUT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
