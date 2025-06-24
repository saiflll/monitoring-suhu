import 'package:flutter/material.dart';
import './notification_menu_button.dart'; 
import './profile_menu_button.dart';
import '../../config/color.dart'; 

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DashboardHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, 
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.black, 
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.white, 
      elevation: 1.0, 
      actions: const [
        NotificationMenuButton(asPopup: true), 
        SizedBox(width: 8),
        ProfileMenuButton(),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}