import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../config/app_routes_constants.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState.initial()) {
    on<DashboardRouteChanged>(_onRouteChanged);
    on<DashboardLogoutRequested>(_onLogoutRequested);
  }

  /// Mengubah judul header berdasarkan nama rute.
  String _getTitleForRoute(String routeName) {
    // Mengambil judul dari peta terpusat. Lebih bersih dan aman.
    // Jika rute tidak ditemukan, defaultnya adalah 'Dashboard'.
    return AppRoutes.pageTitles[routeName] ?? 'Dashboard';
  }

  /// Handler untuk event DashboardRouteChanged.
  void _onRouteChanged(DashboardRouteChanged event, Emitter<DashboardState> emit) {
    print('[DashboardBloc] Received DashboardRouteChanged event for route: ${event.newRouteName}');
    final newTitle = _getTitleForRoute(event.newRouteName);
    emit(state.copyWith(
      currentRouteName: event.newRouteName,
      headerTitle: newTitle,
    ));
    print('[DashboardBloc] Emitted new state with headerTitle: $newTitle');
  }

  void _onLogoutRequested(DashboardLogoutRequested event, Emitter<DashboardState> emit) {
    // Tambahkan logika untuk membersihkan data sesi jika ada.
    emit(const DashboardState()); // Reset state ke kondisi awal.
  }
}