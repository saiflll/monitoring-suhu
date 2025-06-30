import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/titik_model.dart'; 

part 'titik_state.dart';

class TitikCubit extends Cubit<TitikState> {
  TitikCubit() : super(TitikState.initial());

  void pilihTitik(Titik titik) {
    // Hanya emit state baru. Widget peta akan bereaksi terhadap perubahan ini.
    emit(state.copyWith(selected: titik));
  }

  void reset() {
    // Hapus titik yang dipilih. Widget peta akan bereaksi dan mereset view.
    emit(state.copyWith(selected: null));
  }
}