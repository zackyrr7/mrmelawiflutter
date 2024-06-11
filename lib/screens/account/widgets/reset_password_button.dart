import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/theme_color.dart';
import '../blocs/reset_password_bloc/reset_password_cubit.dart';
import 'reset_password_data.dart';
import 'reset_password_form.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: InkWell(
          onTap: () async {
            showModalBottomSheet<ResetPasswordData>(
              context: context,
              builder: (context) {
                return const ResetPasswordForm();
              },
            ).then((value) {
              if (value != null) {
                context.read<ResetPasswordCubit>().resetPassword(resetPasswordData: value);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "RESET PASSWORD",
              style: TextStyle(color: ThemeColor.level4, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
