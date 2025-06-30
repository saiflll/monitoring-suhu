import 'package:flutter/material.dart';
import './notification_menu_button.dart'; 
import './profile_menu_button.dart';
import '../../config/color.dart'; 

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const DashboardHeader({
    super.key,
    required this.title,
    this.height = 80.0, 
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white, 
        border: Border(

          left: BorderSide(color: AppColors.bgblu, width: 1.0),
          right: BorderSide(color: AppColors.bgblu, width: 1.0),
          bottom: BorderSide(color: AppColors.bgblu, width: 5.0), 
        ),
      ),
      child: AppBar(
        toolbarHeight: height,
        automaticallyImplyLeading: false,

        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ),
        actions: const [
          NotificationMenuButton(asPopup: true),
          SizedBox(width: 8),
          ProfileMenuButton(),
          SizedBox(width: 16), 
        ],
      ),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(height);
}
