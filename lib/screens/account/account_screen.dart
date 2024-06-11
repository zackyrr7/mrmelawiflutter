import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/session_cubit.dart';
import '../../widgets/common_bottom_navigation_bar.dart';
import 'blocs/account_bloc/account_cubit.dart';
import 'blocs/account_bloc/account_state.dart';
import 'blocs/reset_password_bloc/reset_password_cubit.dart';
import 'blocs/reset_password_bloc/reset_password_state.dart';
import 'widgets/account_information.dart';
import 'widgets/logout_button.dart';
import 'widgets/reset_password_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late StreamSubscription<AccountState> stateStreamSub;
  late StreamSubscription<ResetPasswordState> resetPasswordStateStreamSub;

  @override
  void initState() {
    stateStreamSub = context.read<AccountCubit>().stream.listen((accountState) {
      if (accountState is AccountSuccess) {
        context.read<SessionCubit>().setSession(null);
      }
    });
    resetPasswordStateStreamSub = context.read<ResetPasswordCubit>().stream.listen((state) {});

    super.initState();
  }

  @override
  void dispose() {
    resetPasswordStateStreamSub.cancel();
    stateStreamSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: AccountInformation(),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ResetPasswordButton(),
                  LogoutButton(),
                  CommonBottomNavigationBar(),
                ],
              )
            ],
          ),
        ),
        BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          builder: (context, state) {
            if (state is ResettingPasswordState) {
              return Container(
                color: Colors.grey.withOpacity(0.8),
                alignment: Alignment.center,
                child: UnconstrainedBox(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        Padding(padding: EdgeInsets.only(top: 8)),
                        Text("Resetting your account password..."),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is SuccessResetPasswordState) {
              return Container(
                color: Colors.grey.withOpacity(0.8),
                alignment: Alignment.center,
                child: UnconstrainedBox(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        TextButton(
                          onPressed: () {
                            context.read<ResetPasswordCubit>().reset();
                          },
                          child: const Text("Close"),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ErrorResetPasswordState) {
              return Container(
                color: Colors.grey.withOpacity(0.8),
                alignment: Alignment.center,
                child: UnconstrainedBox(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.errorMessage),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        TextButton(
                          onPressed: () {
                            context.read<ResetPasswordCubit>().reset();
                          },
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Container();
          },
          listener: (context, state) {},
        ),
      ],
    );
  }
}
