import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/config/color.dart';
import '../../../blocs/features/denah/titik_cubit.dart';
import '../../../models/titik_model.dart';

class MapDetailSidebar extends StatelessWidget {
  const MapDetailSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( 
      decoration: BoxDecoration(
        color: AppColors.white, 
        border: const Border(
          left: BorderSide(
            color: AppColors.bgblu, 
            width: 8.0,       
          ),
        ),
        borderRadius: BorderRadius.circular(8.0), 
      ),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView( 
        child: BlocBuilder<TitikCubit, TitikState>(
          buildWhen: (prev, current) => prev.selected != current.selected,
          builder: (context, state) {
            if (state.selected == null) {
              return _buildAllPointsList(context);
            }
            return _buildPointDetailView(context, state.selected!);
          },
        ),
      ),
    );
  }
  Widget _buildAreaCardContent(BuildContext context, Titik titik) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        color: AppColors.white,
        width: double.infinity,
        child: Text(
          titik.deskripsi,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 12,
            ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        ),
        Row(
        children: [
          Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: AppColors.white,
            child: Row(
            children: [
              const Icon(Icons.thermostat, size: 18, color: AppColors.pri),
              const SizedBox(width: 2),
              _buildInfoColumn(context, 'Suhu', '${titik.suhu}°C'),
            ],
            ),
          ),
          ),
          Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: AppColors.white,
            child: Row(
            children: [
              const Icon(Icons.water_drop, size: 18, color: AppColors.blul),
              const SizedBox(width: 2),
              _buildInfoColumn(context, 'Kelembapan', titik.rh.isNotEmpty ? '${titik.rh}%' : '-'),
            ],
            ),
          ),
          ),
        ],
        ),
      ],
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
        const SizedBox(height: 2),
        Text(value, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }
  Widget _buildAllPointsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
       
        ListView.builder(
          shrinkWrap: true, 
          physics: const NeverScrollableScrollPhysics(), 
          itemCount: titikList.length,
          itemBuilder: (context, index) {
            final titik = titikList[index];
            return Card(
              color: AppColors.bgblu, 
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              clipBehavior: Clip.antiAlias, 
              child: InkWell(
                onTap: () => context.read<TitikCubit>().pilihTitik(titik),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildAreaCardContent(context, titik),
                    ),
                    
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPointDetailView(BuildContext context, Titik titik) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detail Area Terpilih',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.read<TitikCubit>().reset(),
              tooltip: 'Tutup Detail & Tampilkan Semua',
            )
          ],
        ),
        const Divider(),
        const SizedBox(height: 8),
        Card(
          color: Colors.white, 
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: _buildAreaCardContent(context, titik),
        ),
      ],
    );
  }
}