import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'blocs/counter_bloc.dart';
import 'routes/app_router.dart';
import 'blocs/display/dashboard_bloc.dart'; // Import DashboardBloc

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Menyediakan DashboardBloc di level tertinggi aplikasi.
    // Ini memastikan BLoC hanya dibuat sekali dan state-nya bertahan
    // selama pengguna berada di dalam dashboard.
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
