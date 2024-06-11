import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/common_text_field.dart';
import 'reset_password_data.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text("Old Password", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  CommonTextField(hintText: "Old Password", controller: oldPasswordController),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text("New Password", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  CommonTextField(hintText: "New Password", controller: newPasswordController),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text("New Password Confirmation", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  CommonTextField(
                    hintText: "New Password Confirmation",
                    obscureText: true,
                    controller: newPasswordConfirmationController,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                onPressed: () {
                  final oldPassword = oldPasswordController.text;
                  final newPassword = newPasswordController.text;
                  final newPasswordConf = newPasswordConfirmationController.text;
                  if (newPassword != newPasswordConf) return;

                  context.pop(ResetPasswordData(oldPassword: oldPassword, newPassword: newPassword));
                },
                child: const Text("Reset"),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
