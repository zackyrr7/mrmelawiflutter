import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exceptions/network_exception.dart';
import '../../repositories/network_repositories/fiscal_year_network_repository.dart';
import 'fiscal_year_selection_state.dart';

class FiscalYearSelectionCubit extends Cubit<FiscalYearSelectionState> {
  FiscalYearSelectionCubit(super.initialState) {
    fetchYears();
  }

  Future<void> fetchYears() async {
    try {
      emit(LoadingFiscalYear());
      final repository = FiscalYearNetworkRepository();
      final years = await repository.get();
      emit(FiscalYearLoaded(years: years));
    } on NetworkException catch (error) {
      emit(ErrorLoadingFiscalYear(errorMessage: error.errorMessage));
    } catch (error) {
      emit(const ErrorLoadingFiscalYear(errorMessage: "Unable to fetch tahun anggaran"));
    }
  }
}
