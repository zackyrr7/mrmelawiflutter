import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/session_cubit.dart';
import '../blocs/session_state.dart';
import '../constants/theme_color.dart';
import '../podo/user.dart';
import '../routes.dart';

class CommonBottomNavigationBar extends StatefulWidget {
  const CommonBottomNavigationBar({super.key});

  @override
  State<CommonBottomNavigationBar> createState() => _CommonBottomNavigationBarState();
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
  final Map<String, BottomNavigationBarItem> _navigations = {
    AppRoute.home: const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    AppRoute.lra: const BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: "LRA"),
    AppRoute.departmentExpenditure: const BottomNavigationBarItem(icon: Icon(Icons.domain), label: "SKPD"),
    AppRoute.uam: const BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded), label: "UAM"),
    AppRoute.account: const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
  };
  late StreamSubscription<SessionState> _stateStreamSub;
  Map<String, BottomNavigationBarItem> _filteredNavigations = {};

  @override
  void initState() {
    super.initState();
    final sessionState = context.read<SessionCubit>().state;
    filterNavigations(sessionState);
    _stateStreamSub = context.read<SessionCubit>().stream.listen((sessionState) {
      filterNavigations(sessionState);
    });
  }

  void filterNavigations(SessionState sessionState) {
    setState(() {
      if (sessionState is! SessionLoggedIn) {
        _filteredNavigations = {};
      } else {
        final isAccountManager = sessionState.session.user.type == UserType.accountManager;
        _filteredNavigations = {..._navigations};
        if (!isAccountManager) _filteredNavigations.remove("/uam");
      }
    });
  }

  int get index {
    final GoRouterState state = GoRouterState.of(context);
    return _filteredNavigations.keys.toList().indexOf(state.location);
  }

  @override
  void dispose() {
    _stateStreamSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_filteredNavigations.isEmpty) return Container();

    return BottomNavigationBar(
      backgroundColor: ThemeColor.level2,
      selectedItemColor: ThemeColor.level4,
      onTap: (value) {
        context.go(_filteredNavigations.keys.elementAt(value));
      },
      currentIndex: index,
      unselectedItemColor: Colors.grey,
      items: [..._filteredNavigations.values],
    );
  }
}
