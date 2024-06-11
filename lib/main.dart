import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'blocs/session_cubit.dart';
import 'blocs/session_state.dart';
import 'blocs/shared_cubit.dart';
import 'constants/theme_color.dart';
import 'routes.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString("assets/google_fonts/OFL.txt");
    yield LicenseEntryWithLineBreaks(['assets/google_fonts'], license);
  });
  await initializeDateFormatting("id_ID");
  final session = await AuthService.instance.getSession();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SessionCubit(
            session != null ? SessionLoggedIn(session: session) : SessionLoggedOut(),
          ),
        ),
        BlocProvider(create: (context) => SharedCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter routes;
  late StreamSubscription<SessionState> sessionStateSub;

  @override
  void initState() {
    super.initState();

    final state = context.read<SessionCubit>().state;
    final initialLocation = state is SessionLoggedIn ? AppRoute.fiscalYearSelection : AppRoute.login;
    routes = AppRoute(initialLocation).routes;

    sessionStateSub = context.read<SessionCubit>().stream.listen((sessionState) {
      final location = routes.location;

      if (location != AppRoute.login && sessionState is SessionLoggedOut) {
        routes.go(AppRoute.login);
      } else if (location == AppRoute.login && sessionState is SessionLoggedIn) {
        routes.go(AppRoute.fiscalYearSelection);
      }
    });
  }

  @override
  void dispose() {
    sessionStateSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: ThemeColor.level4,
          secondary: ThemeColor.level3,
          tertiary: ThemeColor.level2,
          background: Colors.white,
          outline: ThemeColor.level4,
        ),
      ),
    );
  }
}
