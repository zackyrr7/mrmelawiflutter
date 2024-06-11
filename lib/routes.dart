import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'blocs/shared_cubit.dart';
import 'screens/account/account_screen.dart';
import 'screens/account/blocs/account_bloc/account_cubit.dart';
import 'screens/account/blocs/reset_password_bloc/reset_password_cubit.dart';
import 'screens/account/blocs/reset_password_bloc/reset_password_state.dart';
import 'screens/department_expenditure/department_expenditure_cubit.dart';
import 'screens/department_expenditure/department_expenditure_screen.dart';
import 'screens/fiscal_year_selection/fiscal_year_selection_cubit.dart';
import 'screens/fiscal_year_selection/fiscal_year_selection_screen.dart';
import 'screens/fiscal_year_selection/fiscal_year_selection_state.dart';
import 'screens/home/home_cubit.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_cubit.dart';
import 'screens/login/login_screen.dart';
import 'screens/lra/lra_cubit.dart';
import 'screens/lra/lra_screen.dart';
import 'screens/user_account_management/uam_cubit.dart';
import 'screens/user_account_management/user_account_management_screen.dart';

class AppRoute {
  final String initialLocation;

  static const home = "/";
  static const fiscalYearSelection = "/fiscal-year-selection";
  static const lra = "/lra";
  static const departmentExpenditure = "/department-expenditure";
  static const uam = "/uam";
  static const login = "/login";
  static const account = "/account";

  final _home = GoRoute(
    path: home,
    pageBuilder: (context, state) {
      final selectedYear = context.read<SharedCubit>().state.selectedYear;
      return NoTransitionPage(
        child: selectedYear == null
            ? Container()
            : BlocProvider(
                create: (context) => HomeCubit(year: selectedYear),
                child: const HomeScreen(),
              ),
      );
    },
    redirect: (context, state) {
      final selectedYear = context.read<SharedCubit>().state.selectedYear;
      if (selectedYear == null) return fiscalYearSelection;
      return null;
    },
  );

  final _lra = GoRoute(
    path: lra,
    pageBuilder: (context, state) {
      final selectedYear = context.read<SharedCubit>().state.selectedYear;
      return NoTransitionPage(
        child: selectedYear == null
            ? Container()
            : BlocProvider(
                create: (context) => LraCubit(year: selectedYear),
                child: const LraScreen(),
              ),
      );
    },
    redirect: (context, state) {
      final selectedYear = context.read<SharedCubit>().state.selectedYear;
      if (selectedYear == null) return fiscalYearSelection;
      return null;
    },
  );

  final _department = GoRoute(
    path: departmentExpenditure,
    pageBuilder: (context, state) {
      final selectedYear = context.read<SharedCubit>().state.selectedYear;
      return NoTransitionPage(
        child: selectedYear == null
            ? Container()
            : BlocProvider(
                create: (context) => DepartmentExpenditureCubit(year: selectedYear),
                child: const DepartmentScreen(),
              ),
      );
    },
    redirect: (context, state) {
      final selectedYear = context.read<SharedCubit>().state.selectedYear;
      if (selectedYear == null) return fiscalYearSelection;
      return null;
    },
  );

  final _userManagement = GoRoute(
    path: uam,
    pageBuilder: (context, state) {
      final selectedYear = context.read<SharedCubit>().state.selectedYear;
      return NoTransitionPage(
        child: selectedYear == null
            ? Container()
            : BlocProvider(
                create: (context) => UamCubit(year: selectedYear),
                child: const UserAccountManagementScreen(),
              ),
      );
    },
    redirect: (context, state) {
      final selectedYear = context.read<SharedCubit>().state.selectedYear;
      if (selectedYear == null) return fiscalYearSelection;
      return null;
    },
  );

  final _account = GoRoute(
    path: account,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AccountCubit()),
            BlocProvider(create: (context) => ResetPasswordCubit(ResetPasswordState())),
          ],
          child: const AccountScreen(),
        ),
      );
    },
  );

  final _login = GoRoute(
    path: login,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        child: Scaffold(
          body: BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        ),
      );
    },
  );

  final _fiscalYearSelection = GoRoute(
    path: fiscalYearSelection,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        child: BlocProvider(
          create: (context) => FiscalYearSelectionCubit(const FiscalYearSelectionState()),
          child: const FiscalYearSelectionScreen(),
        ),
      );
    },
  );

  late final _shellRoute = ShellRoute(
    builder: (context, state, child) {
      return Scaffold(
        body: SafeArea(
          child: child,
        ),
      );
    },
    routes: [
      _fiscalYearSelection,
      _home,
      _lra,
      _department,
      _userManagement,
      _account,
    ],
  );

  late final routes = GoRouter(
    initialLocation: initialLocation,
    routes: [
      _login,
      _shellRoute,
    ],
  );

  AppRoute(this.initialLocation);
}
