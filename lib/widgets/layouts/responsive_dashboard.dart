import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../navigation/sidebar.dart'; 
import '../navigation/header.dart'; 
import '../../config/app_routes_constants.dart';
import '../../blocs/display/dashboard_bloc.dart';
import 'responsive_layout.dart';

class DashboardShell extends StatefulWidget {
  final Widget child; 
  final GoRouterState routeState;

  const DashboardShell({super.key, required this.child, required this.routeState});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {

  @override
  void initState() {
    super.initState();
    // Dispatch event for the initial route when the widget is first created.
    _dispatchRouteChanged(_extractRouteNameFromPath(widget.routeState.fullPath));
  }

  @override
  void didUpdateWidget(covariant DashboardShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kDebugMode) {
      print('[DashboardShell] didUpdateWidget called.');
    }
    // Saat router menyediakan widget baru (karena rute berubah), bandingkan rute lama dan baru.
    // Menggunakan fullPath lebih robust jika name tidak selalu tersedia atau akurat di ShellRoute.
    final oldFullPath = oldWidget.routeState.fullPath;
    final newFullPath = widget.routeState.fullPath;
    if (kDebugMode) {
      print('[DashboardShell] oldFullPath: $oldFullPath, newFullPath: $newFullPath');
    }

    if (oldFullPath != newFullPath) {
      // Ekstrak nama rute dari fullPath.
      // Contoh: '/dashboard/settings' -> 'settings'
      // Pastikan untuk menangani kasus root path seperti '/dashboard'
      final newRouteName = _extractRouteNameFromPath(newFullPath);
      _dispatchRouteChanged(newRouteName);
    }
  }

  /// Method helper untuk mengirim event ke BLoC secara aman.
  void _dispatchRouteChanged(String? routeName) {
    final activeRouteName = routeName ?? AppRoutes.home;
    if (kDebugMode) {
      print('[DashboardShell] Dispatching DashboardRouteChanged for: $activeRouteName');
    }
    // Menggunakan context.read aman di dalam lifecycle methods.
    context.read<DashboardBloc>().add(DashboardRouteChanged(activeRouteName));
  }

  // Helper function to extract the route name from the full path
  String _extractRouteNameFromPath(String? fullPath) {
    if (fullPath == null || fullPath.isEmpty || fullPath == AppRoutes.dashboardBase) {
      return AppRoutes.home;
    }
    return AppRoutes.fullPathToRouteName[fullPath] ?? AppRoutes.home;
  }

  void _handleNavigation(BuildContext context, String routeNameOrAction) {
    if (routeNameOrAction == AppRoutes.logoutAction) {
      context.read<DashboardBloc>().add(DashboardLogoutRequested());
      context.goNamed(AppRoutes.login);
    } else {
      context.goNamed(routeNameOrAction);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Logika pengiriman event sudah dipindahkan ke initState/didUpdateWidget.
    // Method build sekarang menjadi "murni" dan hanya fokus membangun UI.

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        // State dari BLoC sekarang menjadi satu-satunya sumber kebenaran untuk judul.
        if (kDebugMode) {
          print('[DashboardShell] Rebuilding with BLoC state headerTitle: ${state.headerTitle}');
        }
        final String headerTitle = state.headerTitle;
        final String activeRouteName = state.currentRouteName; // <-- AMBIL DARI STATE!

        bool isTrulyMobile = MediaQuery.of(context).size.width < ResponsiveLayout.tabletBreakpointMin;
        return ResponsiveLayout(
          mobileAppBar: isTrulyMobile 
              ? AppBar(
                  title: Text(headerTitle),
                ) 
              : null,
          mobileBody: _buildMainContentArea(context, widget.child, headerTitle, isMobile: true),
          desktopBody: _buildMainContentArea(context, widget.child, headerTitle, isMobile: false),
          // Gunakan `activeRouteName` dari GoRouter untuk meneruskan ke child widgets.
          desktopSidebar: AppSidebar(
            activeRoute: activeRouteName,
            onNavigate: (routeName) => _handleNavigation(context, routeName),
          ),
          mobileBottomNavigationBar: MobileNav(
            activeRouteName: activeRouteName,
            onNavigate: (routeName) => _handleNavigation(context, routeName),
          ),
        );
      },
    );
  }

  Widget _buildMainContentArea(BuildContext context, Widget currentView, String headerTitle, {required bool isMobile}) {
    return Column(
      children: [
        if (!isMobile)
          DashboardHeader(title: headerTitle), 
        if (!isMobile) const SizedBox(height: 4), 
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView( 
              child: currentView, 
            ),
          ),
        ),
      ],
    );
  }
}