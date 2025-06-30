import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/widgets/layouts/responsive_layout.dart';
import '../blocs/features/home/home_data_bloc.dart';
import '../blocs/features/denah/titik_cubit.dart'; 
import '../models/titik_model.dart';
// ignore: unused_import
import '../config/color.dart'; 
import '../widgets/home_sections/mobile_home_layout.dart'; 
import '../widgets/features/common/functional_filter_bar.dart';
import '../widgets/features/denah/interactive_map_widget.dart';
import '../widgets/features/denah/map_detail_sidebar.dart';
import '../widgets/home_sections/table_detail_section.dart';
import '../widgets/home_sections/chart_section.dart';
import '../widgets/home_sections/gauge_alert_section.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TitikCubit()),
        BlocProvider(
          create: (context) => HomeDataBloc()..add(HomeDataFetched()),
        ),
      ],
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<TitikCubit, TitikState>(
              listenWhen: (prev, current) => prev.selected != current.selected,
              listener: (context, titikState) {
                if (titikState.selected != null) {
                  final homeBloc = context.read<HomeDataBloc>();
                  final currentFilter = homeBloc.state.filterSelection;

                  final areaName =
                      Titik.getAreaNameFromId(titikState.selected!.id);

                  if (areaName != null &&                      
                      areaName != currentFilter.selectedRoom) {
                    homeBloc.add(
                      HomeDataFilterChanged(
                        currentFilter.copyWith(selectedRoom: areaName),
                      ),
                    );
                  }
                }
              },
            ),
            BlocListener<HomeDataBloc, HomeDataState>(
              listenWhen: (previous, current) =>
                  previous.filterSelection.selectedRoom !=
                  current.filterSelection.selectedRoom,
              listener: (context, homeState) {
                final selectedRoom = homeState.filterSelection.selectedRoom;
                final titikCubit = context.read<TitikCubit>();

                if (selectedRoom != null) {
                  try {
                    // Cari titik yang cocok berdasarkan deskripsinya.
                    final titikToSelect =
                        titikList.firstWhere((t) => t.deskripsi == selectedRoom);

                    // Untuk mencegah loop, hanya update jika titiknya berbeda.
                    if (titikCubit.state.selected != titikToSelect) {
                      titikCubit.pilihTitik(titikToSelect);
                    }
                  } catch (e) {
                    // Jika tidak ada titik yang cocok, reset sorotan di peta.
                    if (titikCubit.state.selected != null) {
                      titikCubit.reset();
                    }
                  }
                }
              },
            ),
          ],
          child: PopScope(
            canPop: context.watch<TitikCubit>().state.selected == null,
            onPopInvoked: (didPop) {
              if (!didPop) {
                context.read<TitikCubit>().reset();
              }
            },
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKey: (event) {
                if (event is RawKeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.escape) {
                  context.read<TitikCubit>().reset();
                }
              },
              child: LayoutBuilder(builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >=
                    ResponsiveLayout.desktopBreakpointMin;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: isDesktop
                      ? const <Widget>[_DesktopLayout()]
                      : const <Widget>[
                          MobileHomeLayout(),
                        ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}


class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, HomeDataState>(
      builder: (context, state) {
        if (state.status == HomeDataStatus.initial || state.status == HomeDataStatus.loading && state.tempGaugeData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FunctionalFilterBar(
              title: 'Dashboard',
              filterSelection: state.filterSelection,
              areaItems: state.areaItems,
              deviceItems: state.deviceItems,
              timeCountItems: state.timeCountItems,
            ),
            const SizedBox(height: 8),
            const _MapSection(),
            const SizedBox(height: 8),
            const GaugeAlertSection(),
            const SizedBox(height: 8),
            ChartSection(chartDataSelector: (state) => state.tempChartData),
            const SizedBox(height: 8),
            ChartSection(chartDataSelector: (state) => state.humidityChartData),
            const SizedBox(height: 8),
            const TableDetailSection(),
          ],
        );
      },
    );
  }
}

class _MapSection extends StatelessWidget {
  const _MapSection();

  @override
  Widget build(BuildContext context) {
    // Atur tinggi denah dan sidebar di sini.
    return SizedBox(
      height: 750, // <-- UBAH NILAI INI UNTUK MENGATUR TINGGI DENAH
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Agar anak mengisi tinggi
        children: [
          const Expanded(
            flex: 3, // Peta mengambil ruang 3x lebih banyak dari sidebar
            child: InteractiveMapWidget(isRotated: false), // Desktop = landscape
          ),
          const SizedBox(width: 8),
          // Sidebar untuk detail titik yang dipilih
          const Expanded(
            flex: 1,
            child: MapDetailSidebar(),
          ),
        ],
      ),
    );
  }
}
