import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/session_cubit.dart';
import '../../constants/theme_color.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/state_screen/error_screen.dart';
import '../../widgets/state_screen/loading_screen.dart';
import 'login_cubit.dart';
import 'login_state.dart';
import 'policy_screen.dart';
import 'widgets/background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late StreamSubscription<LoginState> loginStateStreamSub;

  @override
  void initState() {
    loginStateStreamSub =
        context.read<LoginCubit>().stream.listen((loginState) {
      if (loginState is LoginSuccess) {
        context.read<SessionCubit>().setSession(loginState.session);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateStreamSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.asset("assets/images/mr_logo.png"),
                  ),
                ),
              ),
              Text("Email",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: 4)),
              CommonTextField(controller: emailController),
              const Padding(padding: EdgeInsets.only(top: 8)),
              Text("Password",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: 4)),
              CommonTextField(
                  obscureText: true, controller: passwordController),
              const Padding(padding: EdgeInsets.only(top: 16)),
              Material(
                color: ThemeColor.level4,
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.hardEdge,
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    context.read<LoginCubit>().login(
                        email: emailController.text,
                        password: passwordController.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text("LOGIN",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PoliciesScreen()));
                        },
                        child: const Text(
                          "Privacy & Policy",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold),
                        ))),
              )
            ],
          ),
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading)
              return const LoadingScreen(message: "Logging in...");

            if (state is LoginError) {
              return ErrorScreen(
                title: "Failed to authenticate",
                message: state.error,
                onRetry: () {
                  context.read<LoginCubit>().login(
                      email: emailController.text,
                      password: passwordController.text);
                },
                onCancel: () {
                  context.read<LoginCubit>().setInitial();
                },
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
