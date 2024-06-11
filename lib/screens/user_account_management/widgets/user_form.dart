import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../podo/department.dart';
import '../../../podo/user.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_text_field.dart';

class UserForm extends StatefulWidget {
  final List<Department> departments;
  const UserForm({super.key, required this.departments});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  UserType _userType = UserType.general;
  Department? department;

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
                  Text("Name", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  CommonTextField(hintText: "Name", controller: nameController),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text("Email", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  CommonTextField(hintText: "Email", controller: emailController),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text("Password", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  CommonTextField(hintText: "Password", obscureText: true, controller: passwordController),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text("SKPD", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  CommonDropdown<Department?>(
                    value: department,
                    isExpanded: true,
                    items: widget.departments,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          department = value;
                        });
                      }
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text("Type", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  CommonDropdown<UserType>(
                    value: _userType,
                    items: UserType.values,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _userType = value;
                        });
                      }
                    },
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
                  final department = this.department;
                  if (department == null) return;
                  final user = User(
                    email: emailController.text,
                    name: nameController.text,
                    password: passwordController.text,
                    type: _userType,
                    department: department,
                  );
                  context.pop(user);
                },
                child: const Text("Save"),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              TextButton(
                onPressed: () {
                  context.pop(null);
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
