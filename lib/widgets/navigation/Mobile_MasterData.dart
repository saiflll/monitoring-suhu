
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testv1/config/color.dart';
import 'package:testv1/widgets/navigation/sidebar.dart'; // To access masterDataRoutesMap

/// A page that displays a list of master data options for navigation.
/// This is typically used in mobile view where there isn't enough space for an expansion tile.
class MasterDataSelectionPage extends StatelessWidget {
  const MasterDataSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the master data routes from the central definition in AppSidebar
    final masterDataRoutes = AppSidebar.masterDataRoutesMap;

    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: masterDataRoutes.entries.map((entry) {
        final displayText = entry.key;
        final routeName = entry.value;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: const Icon(Icons.storage_rounded, color: AppColors.pri),
            title: Text(
              displayText.replaceAll('〇 ', ''), // Clean up the display text
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.gra),
            onTap: () {
              context.goNamed(routeName);
            },
          ),
        );
      }).toList(),
    );
  }
}