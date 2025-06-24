import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/home_page.dart';
//import '../views/tv_page.dart';
import 'package:testv1/views/login.dart';
import '../views/not_found_page.dart';
import '../widgets/layouts/responsive_dashboard.dart'; 
import '../widgets/navigation/Mobile_MasterData.dart'; // Import the new page
//import '../blocs/dashboard/dashboard_bloc.dart';
import '../config/app_routes_constants.dart';

class MasterDataContainerWidget extends StatelessWidget {
  final String title;
  const MasterDataContainerWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, 
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.login, 
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login, 
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return DashboardShell(routeState: state, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.homeFullPath, 
            name: AppRoutes.home,
            builder: (context, state) => const HomePage(), 
          ),
          GoRoute(
            path: AppRoutes.masterDataFullPath,
            name: AppRoutes.masterData,
            builder: (context, state) => const MasterDataSelectionPage(),
          ),
            GoRoute(
            path: AppRoutes.masterDataAreaFullPath, 
            name: AppRoutes.masterDataArea,
            builder: (context, state) => const MasterDataContainerWidget(title: 'Master Data Area Content'),
            ),
            GoRoute(
            path: AppRoutes.masterDataDepartmentFullPath, 
            name: AppRoutes.masterDataDepartment,
            builder: (context, state) => const MasterDataContainerWidget(title: 'Master Data Department Content'),
            ),
            GoRoute(
            path: AppRoutes.masterDataPlantFullPath, 
            name: AppRoutes.masterDataPlant,
            builder: (context, state) => const MasterDataContainerWidget(title: 'Master Data Plant Content'),
            ),
            GoRoute(
            path: AppRoutes.masterDataRoleFullPath, 
            name: AppRoutes.masterDataRole,
            builder: (context, state) => const MasterDataContainerWidget(title: 'Master Data Role Content'),
            ),
            GoRoute(
            path: AppRoutes.masterDataUserFullPath, 
            name: AppRoutes.masterDataUser,
            builder: (context, state) => const MasterDataContainerWidget(title: 'Master Data User Content'),
            ),
          GoRoute(
            path: AppRoutes.settingsFullPath, 
            name: AppRoutes.settings,
            builder: (context, state) => const Center(child: Text('Settings Page Content')),
          ),
          GoRoute(
            path: AppRoutes.notificationsFullPath, 
            name: AppRoutes.notifications,
            builder: (context, state) => const Center(child: Text('Notifications Page Content')),
          ),
          GoRoute(
            path: AppRoutes.profileFullPath, 
            name: AppRoutes.profile,
            builder: (context, state) => const Center(child: Text('Profile Page Content')),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
