import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testv1/config/color.dart';
import '../../config/app_routes_constants.dart';
//import '../../config/color.dart'; 

class ProfileMenuButton extends StatelessWidget {
  const ProfileMenuButton({super.key});

  void _handleProfileSelection(BuildContext context, String value) {
    switch (value) {
      case 'profile':
        context.goNamed(AppRoutes.profile);
        break;
      case 'settings':
        context.goNamed(AppRoutes.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        foregroundColor: AppColors.pri, // Icon color
        radius: 22,
        //backgroundImage: AssetImage('assets/Profil.png'), 
        //backgroundColor: AppColors.pri,      
        child: Icon(Icons.account_circle_outlined),
      ),
      tooltip: 'Profil Pengguna',
      offset: const Offset(0, 40), 
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'profile',
          child: ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Profil Saya'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'settings',
          child: ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Pengaturan'),
          ),
        ),
        
      ],
      onSelected: (String value) => _handleProfileSelection(context, value),
    );
  }
}
