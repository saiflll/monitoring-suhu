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
              listenWhen: (previous, current) => previous.selected != current.selected,
              listener: (context, titikState) {
                final selectedTitik = titikState.selected;
                if (selectedTitik != null) {
                  final homeBloc = context.read<HomeDataBloc>();
                  final currentFilter = homeBloc.state.filterSelection;
                  final newAreaName = selectedTitik.deskripsi;
                  final newDeviceName = 'Device ${selectedTitik.no}';
                  if (newAreaName != currentFilter.selectedRoom || newDeviceName != currentFilter.selectedSensor) {
                    homeBloc.add(HomeDataFilterChanged(
                      currentFilter.copyWith(
                        selectedRoom: newAreaName,
                        selectedSensor: newDeviceName,
                      ),
                    ));
                  }
                }
              },
            ),
            BlocListener<HomeDataBloc, HomeDataState>(
              listenWhen: (previous, current) =>
                  previous.filterSelection.selectedRoom != current.filterSelection.selectedRoom ||
                  previous.filterSelection.selectedSensor != current.filterSelection.selectedSensor,
              listener: (context, homeState) {
                final filter = homeState.filterSelection;
                final selectedRoom = filter.selectedRoom;
                final selectedSensor = filter.selectedSensor;
                final titikCubit = context.read<TitikCubit>();
                if (selectedRoom.isEmpty || selectedSensor.isEmpty) {
                  if (titikCubit.state.selected != null) titikCubit.reset();
                  return;
                }
                final deviceNumber = int.tryParse(selectedSensor.split(' ').last);
                if (deviceNumber == null) {
                  if (titikCubit.state.selected != null) titikCubit.reset();
                  return;
                }
                try {
                  final titikToSelect = titikList.firstWhere(
                    (t) => t.deskripsi == selectedRoom && t.no == deviceNumber,
                  );

                  if (titikCubit.state.selected != titikToSelect) {
                    titikCubit.pilihTitik(titikToSelect);
                  }
                } catch (e) {
                  if (titikCubit.state.selected != null) {
                    titikCubit.reset();
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
            Container(
              decoration: BoxDecoration(
                //color: AppColors.pri, 
                border: Border.all(color: AppColors.bgblu, width: 6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FunctionalFilterBar(
              title: 'PPA CK-3 MANUFACTURING PLAN',
              filterSelection: state.filterSelection,
              areaItems: state.areaItems,
              //deviceItems: state.deviceItems,
              //timeCountItems: state.timeCountItems,
              showDateRangePicker: false, 
              showExportButton: false,   
              ),
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

//map conf
class _MapSection extends StatelessWidget {
  const _MapSection();

  @override
  Widget build(BuildContext context) {
    // Bungkus dengan BlocBuilder untuk mendengarkan perubahan dari TitikCubit
    return BlocBuilder<TitikCubit, TitikState>(
      builder: (context, titikState) {
        // Tentukan teks judul berdasarkan state
        final String titleText;
        if (titikState.selected != null) {
          final titik = titikState.selected!;
          titleText = '${titik.deskripsi} - No: ${titik.no}';
        } else {
          titleText = 'Denah Plan';
        }

        return SizedBox(
          height: 750,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.bgblu, width: 8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.bgblu,
                          width: 8,
                        ),
                      ),
                    ),
                    child: Text(
                      titleText, // Gunakan teks judul yang dinamis
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Mencegah teks meluap
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          flex: 3,
                          child: InteractiveMapWidget(isRotated: false),
                        ),
                        const SizedBox(width: 8),
                        // Sidebar untuk detail titik yang dipilih
                        const Expanded(
                          flex: 1,
                          child: MapDetailSidebar(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
        