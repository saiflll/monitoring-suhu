part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

/// Event yang dikirim ketika rute navigasi berubah.
/// Berisi nama rute yang baru.
class DashboardRouteChanged extends DashboardEvent {
  final String newRouteName;

  const DashboardRouteChanged(this.newRouteName);

  @override
  List<Object> get props => [newRouteName];
}

/// Event yang dikirim ketika pengguna menekan tombol logout.
class DashboardLogoutRequested extends DashboardEvent {}