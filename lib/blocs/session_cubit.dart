import 'package:flutter_bloc/flutter_bloc.dart';

import '../podo/session.dart';
import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(super.initialState);

  void setSession(Session? session) {
    if (session == null) {
      emit(SessionLoggedOut());
    } else {
      emit(SessionLoggedIn(session: session));
    }
  }
}
