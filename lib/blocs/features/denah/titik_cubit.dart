import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/titik_model.dart'; // Updated import path

part 'titik_state.dart';

class TitikCubit extends Cubit<TitikState> {
  TitikCubit() : super(TitikState.initial());

  void pilihTitik(Titik titik) {
    // Jika titik yang diklik memiliki `targetStage`, maka navigasikan ke stage tersebut.
    if (titik.targetStage != null) {
      // Pindah ke stage target dan reset titik yang dipilih agar sidebar info tidak muncul.
      emit(TitikState(stage: titik.targetStage!, selected: null));
    } else {
      // Jika tidak, lakukan perilaku default: pilih titik pada stage saat ini.
      emit(state.copyWith(selected: titik, stage: titik.backgroundStage));
    }
  }

  void reset() => emit(TitikState.initial());
}