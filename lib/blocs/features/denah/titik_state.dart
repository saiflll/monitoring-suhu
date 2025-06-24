part of 'titik_cubit.dart';

class TitikState extends Equatable {
  final Titik? selected;
  final int stage;

  const TitikState({this.selected, this.stage = 0});

  factory TitikState.initial() => const TitikState(selected: null, stage: 0);

  TitikState copyWith({Titik? selected, int? stage}) {
    return TitikState(
      selected: selected ?? this.selected,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object?> get props => [selected, stage];
}