part of 'titik_cubit.dart';

class TitikState extends Equatable {
  // Titik yang sedang dipilih
  final Titik? selected;

  const TitikState({
    this.selected,
  });

  // State awal, membuat instance baru dari TransformationController
  factory TitikState.initial() => const TitikState();

  TitikState copyWith({
    Titik? selected,
  }) {
    return TitikState(
      selected: selected,
    );
  }

  @override
  List<Object?> get props => [
        selected,
      ];
}