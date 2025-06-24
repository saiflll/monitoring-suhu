part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  /// Menyimpan nama rute yang sedang aktif (misal: 'home', 'settings').
  final String currentRouteName;

  /// Menyimpan judul yang akan ditampilkan di header.
  final String headerTitle;

  const DashboardState({
    this.currentRouteName = AppRoutes.home,
    this.headerTitle = 'Dashboard', // Nilai ini akan di-override oleh BLoC
  });
  
  // Factory constructor untuk state awal yang lebih cerdas.
  factory DashboardState.initial() {
    const initialRoute = AppRoutes.home;
    // Mengambil judul awal dari peta, bukan di-hardcode.
    final initialTitle = AppRoutes.pageTitles[initialRoute] ?? 'Dashboard';
    return DashboardState(currentRouteName: initialRoute, headerTitle: initialTitle);
  }

  DashboardState copyWith({
    String? currentRouteName,
    String? headerTitle,
  }) {
    return DashboardState(
      currentRouteName: currentRouteName ?? this.currentRouteName,
      headerTitle: headerTitle ?? this.headerTitle,
    );
  }

  @override
  List<Object> get props => [currentRouteName, headerTitle];
}