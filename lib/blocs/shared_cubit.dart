import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(const SharedState());

  void setYear(int year) {
    emit(SharedState(selectedYear: year));
  }
}
