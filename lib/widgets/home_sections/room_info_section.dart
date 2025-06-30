import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/color.dart';
import '../../blocs/features/home/home_data_bloc.dart';
import '../../models/titik_model.dart';
import '../common/app_containers.dart';
import '../common/custom_dropdown.dart';

class RoomInfoSection extends StatelessWidget {
  const RoomInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: const Color.fromARGB(0, 0, 0, 0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kontainer atas untuk judul
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.bgblu,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title and subtitle
                const Expanded(
                  child: Text(
                    'Informasi Ruangan',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // Dropdown
                BlocBuilder<HomeDataBloc, HomeDataState>(
                  buildWhen: (previous, current) =>
                      previous.filterSelection?.selectedRoom != current.filterSelection?.selectedRoom,
                  builder: (context, state) {
                    if (state.filterSelection == null) {
                      return const SizedBox.shrink(); // or a loading indicator
                    }
                    final areaItems = Titik.areaNames;
                    return CustomDropdown(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      borderRadius: BorderRadius.circular(15),
                      value: state.filterSelection!.selectedRoom,
                      items: areaItems,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          context.read<HomeDataBloc>().add(
                                HomeDataFilterChanged(state.filterSelection!.copyWith(selectedRoom: newValue)),
                              );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}