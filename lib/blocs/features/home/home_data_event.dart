part of 'home_data_bloc.dart';

abstract class HomeDataEvent extends Equatable {
  const HomeDataEvent();

  @override
  List<Object> get props => [];
}

class HomeDataFetched extends HomeDataEvent {}

class HomeDataFilterChanged extends HomeDataEvent {
  final FilterSelection newFilter;

  const HomeDataFilterChanged(this.newFilter);

  @override
  List<Object> get props => [newFilter];
}