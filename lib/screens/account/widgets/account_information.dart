import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../blocs/session_cubit.dart';
import '../../../blocs/session_state.dart';
import '../../../constants/theme_color.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (previous, current) {
        return previous is SessionLoggedIn && current is SessionLoggedIn && previous != current;
      },
      builder: (context, state) {
        if (state is! SessionLoggedIn) return Container();

        final user = state.session.user;
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: 92,
                height: 92,
                child: CircleAvatar(
                  backgroundColor: ThemeColor.level4,
                  child: Icon(Icons.person, size: 56),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              Text(user.name, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: 4)),
              Text(user.type.toString(), style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: 4)),
              Text(user.email),
            ],
          ),
        );
      },
    );
  }
}
