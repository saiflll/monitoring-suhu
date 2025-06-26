import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/widgets/layouts/responsive_layout.dart';
import '../blocs/features/denah/titik_cubit.dart'; 
// ignore: unused_import
import '../config/color.dart';
import '../widgets/home_sections/mobile_home_layout.dart'; 
import '../widgets/home_sections/room_info_section.dart';
import '../widgets/home_sections/table_detail_section.dart';
import '../widgets/home_sections/temp_graph_section.dart';
import '../widgets/home_sections/gauge_alert_section.dart'; 
import '../widgets/home_sections/rh_graph_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TitikCubit(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop =
              constraints.maxWidth >= ResponsiveLayout.desktopBreakpointMin;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: isDesktop
                ? const [_DesktopLayout()]
                : const [
                    MobileHomeLayout(),
                  ],
          );
        },
      ),
    );
  }
}


class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RoomInfoSection(),
        SizedBox(height: 8),
        GaugeAlertSection(),
        TempGraphSection(),
        SizedBox(height: 8),
        RHGraphSection(),
        SizedBox(height: 8),
        TableDetailSection(),
      ],
    );
  }
}
