import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/theme_color.dart';
import '../../podo/user.dart';
import '../../widgets/common_bottom_navigation_bar.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/state_screen/error_screen.dart';
import '../../widgets/state_screen/loading_screen.dart';
import 'uam_cubit.dart';
import 'uam_state.dart';
import 'widgets/user_form.dart';
import 'widgets/user_item.dart';

class UserAccountManagementScreen extends StatelessWidget {
  const UserAccountManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<User> users = context.select<UamCubit, List<User>>((value) => value.state.users);

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                color: ThemeColor.level1,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Users", style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 20)),
                        FilledButton(
                          onPressed: () {
                            final departments = context.read<UamCubit>().state.departments;
                            showModalBottomSheet<User>(
                              context: context,
                              builder: (context) {
                                return UserForm(departments: departments);
                              },
                            ).then((user) {
                              if (user != null) {
                                context.read<UamCubit>().addUser(user);
                              }
                            });
                          },
                          child: const Text("Create"),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return UserItem(
                            user: users[index],
                            onDelete: (user) {
                              showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return const ConfirmationDialog(
                                    title: "User Deletion",
                                    message: "Are you sure you want to delete this user?",
                                  );
                                },
                              ).then((deleteUser) {
                                if (deleteUser != null && deleteUser) {
                                  context.read<UamCubit>().deleteUser(user);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<UamCubit, UamState>(
                buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                builder: (context, state) {
                  if (state is UamLoadingState) return LoadingScreen(message: state.message);

                  if (state is UamErrorState) {
                    return ErrorScreen(
                      title: "Unable to create user",
                      message: state.error,
                      onCancel: () {
                        context.read<UamCubit>().reset();
                      },
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
        const CommonBottomNavigationBar(),
      ],
    );
  }
}
