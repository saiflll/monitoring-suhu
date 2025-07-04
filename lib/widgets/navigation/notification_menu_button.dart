import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_routes_constants.dart'; 
import '../../config/color.dart';

class NotificationMenuButton extends StatelessWidget {
  final bool asPopup;

  const NotificationMenuButton({
    super.key,
    this.asPopup = true, 
  });

  void _handleNotificationSelection(BuildContext context, String value) {
    
    switch (value) {
      case 'view_all':
        
        context.goNamed(AppRoutes.notifications);
        break;
      
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    if (asPopup) {
      return PopupMenuButton<String>(
        icon: const Icon(Icons.notifications_none, color: AppColors.pri, size: 35,), 
        tooltip: 'Notifikasi', 
        offset: const Offset(0, 40), 
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'notification_1',
            child: ListTile(
              leading: Icon(Icons.message_outlined),
              title: Text('Pesan baru dari Admin'),
              subtitle: Text('Klik untuk melihat detail'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'notification_2',
            child: ListTile(
              leading: Icon(Icons.timer_outlined),
              title: Text('Tugas Anda akan segera berakhir'),
              subtitle: Text('Selesaikan sebelum batas waktu'),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'view_all',
            child: Center(child: Text('Lihat Semua Notifikasi')),
          ),
        ],
        onSelected: (String value) => _handleNotificationSelection(context, value),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.notifications_none_outlined, color: Colors.grey),
        tooltip: 'Notifikasi',
        onPressed: () {
          context.goNamed(AppRoutes.notifications);
        },
      );
    }
  }
}