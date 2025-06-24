import 'package:flutter/material.dart';
import '../../config/color.dart'; // Import file warna global Anda
import '../../config/app_routes_constants.dart'; // Import AppRoutes

class AppSidebar extends StatelessWidget {
  final String activeRoute;
  final Function(String) onNavigate; // Expects a GoRouter route NAME or action string

  const AppSidebar({
    super.key,
    required this.activeRoute,
    required this.onNavigate,
  });

  // Helper map for Master Data routes
  static final Map<String, String> masterDataRoutesMap = {
    '〇 Data Area': AppRoutes.masterDataArea,
    '〇 Data Department': AppRoutes.masterDataDepartment,
    '〇 Data Plant': AppRoutes.masterDataPlant,
    '〇 Data Role': AppRoutes.masterDataRole,
    '〇 Data User': AppRoutes.masterDataUser,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // Lebar tetap untuk sidebar
      height: double.infinity, // Fill available height
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onNavigate(AppRoutes.home);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 108,
                height: 70,
                child: Image.asset(
                    'assets/logo.png'), // Pastikan path asset benar dan ada di pubspec.yaml
                ),
            ),
          ),
          const SizedBox(height: 25),
          _buildSidebarMenuItem(
            icon: Icons.home_filled,
            text: 'Dashboard', // Langsung gunakan judul yang benar
            routeName: AppRoutes.home, // Nama rute untuk navigasi
            isActive: activeRoute == AppRoutes.home,
            onNavigate: onNavigate,
          ),
          _buildSidebarExpansionItem(
            icon: Icons.layers,
            text: 'Master Data',
            childrenDisplayTexts: masterDataRoutesMap.keys.toList(),
            activeRoute: activeRoute,
            onNavigate: onNavigate,
          ),
          const Spacer(),
          _buildSidebarMenuItem(
            icon: Icons.settings,
            text: 'Settings',
            routeName: AppRoutes.settings,
            isActive: activeRoute == AppRoutes.settings,
            onNavigate: onNavigate,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: AppColors.subpri,
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: ListTile(
              leading: const Icon(Icons.logout, color: AppColors.white),
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: AppColors.subpri,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    ),
                ),
              ),
              onTap: () {
                onNavigate(AppRoutes.logoutAction);
              },
              dense: true,
              minLeadingWidth: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSidebarMenuItem({
    required IconData icon,
    required String text,
    required String routeName,
    bool isActive = false,
    required Function(String) onNavigate,
    // bool showText = true, // Teks selalu ditampilkan, jadi parameter ini bisa dihilangkan jika tidak ada logika lain
  }) {
    final Color iconColor = isActive ? AppColors.subpri : AppColors.gra;
    final Color textColor = isActive ? AppColors.subpri : AppColors.gra;
    final Color backgroundColor = isActive ? AppColors.bgblu : Colors.transparent;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
        onTap: () {
          onNavigate(routeName);
        },
        dense: true,
        minLeadingWidth: 0,
      ),
    );
  }

  Widget _buildSidebarExpansionItem({
    required IconData icon,
    required String text,
    required List<String> childrenDisplayTexts,
    String? activeRoute,
    required Function(String) onNavigate,
    // bool showText = true, // Teks selalu ditampilkan
  }) {
    // Determine if any child of this expansion tile is the active route
    final bool isParentActive = masterDataRoutesMap.values.any((route) => activeRoute == route);
    
    // Determine colors for the header based on whether a child is active
    final Color headerItemColor = isParentActive ? AppColors.subpri : AppColors.gra;
    final Color headerBackgroundColor = isParentActive ? Colors.transparent : Colors.transparent;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: headerBackgroundColor,
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: ExpansionTile(
        // Keep the tile expanded if one of its children is active
        initiallyExpanded: isParentActive,
        leading: Icon(icon, color: headerItemColor), // Warna ikon header
        title: Text(text,
            style: TextStyle(color: headerItemColor, fontWeight: FontWeight.w600)), // Warna teks header
        iconColor: headerItemColor, // Warna panah saat expanded
        collapsedIconColor: headerItemColor, // Warna panah saat collapsed
        children: childrenDisplayTexts.map((displayText) {
          final routeName = masterDataRoutesMap[displayText];
          final bool isChildActive = activeRoute == routeName;

          return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                displayText, // Hapus style dari sini agar ListTile bisa mengontrol warna teks
              ), 
            ),
            // Style untuk sub-item, bisa disesuaikan jika perlu dibedakan saat aktif
            selected: isChildActive,
            selectedTileColor: AppColors.bgblu, // Latar belakang untuk sub-item yang terpilih
            selectedColor: AppColors.subpri,    // Warna teks untuk sub-item yang terpilih
            textColor: AppColors.gra,           // Warna teks default untuk sub-item
            dense: true,
            onTap: () {
              if (routeName != null) {
                onNavigate(routeName);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}

class MobileNav extends StatelessWidget {
  final String activeRouteName;
  final Function(String) onNavigate;

  const MobileNav({
    super.key,
    required this.activeRouteName,
    required this.onNavigate,
  });

  // Helper method to get route name from index
  String _getRouteFromIndex(int index) {
    switch (index) {
      case 0:
        return AppRoutes.home;
      case 1:
        // Navigate to the master data selection page
        return AppRoutes.masterData;
      case 2:
        return AppRoutes.notifications;
      case 3:
        return AppRoutes.settings;
      case 4:
        return AppRoutes.profile;
      default:
        return AppRoutes.home;
    }
  }

  int _getIndexFromRoute(String routeName) {
    if (routeName == AppRoutes.home) return 0;
    if (routeName == AppRoutes.masterData || // Add the parent route
        routeName == AppRoutes.masterDataArea ||
        routeName == AppRoutes.masterDataDepartment ||
        routeName == AppRoutes.masterDataPlant ||
        routeName == AppRoutes.masterDataRole ||
        routeName == AppRoutes.masterDataUser) {
      return 1;
    }
    if (routeName == AppRoutes.notifications) return 2;
    if (routeName == AppRoutes.settings) return 3;
    if (routeName == AppRoutes.profile) return 4;
    return 0; // Default to Home
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _getIndexFromRoute(activeRouteName);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) {
        onNavigate(_getRouteFromIndex(index));
      },
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.pri,
      unselectedItemColor: AppColors.gray,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Dashboard', // Langsung gunakan judul yang benar
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.storage),
          label: 'Data Master',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}