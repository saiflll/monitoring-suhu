class AppRoutes {

  static const String login = '/login'; 
  static const String dashboardBase = '/dashboard'; 


  static const String home = 'home';
  static const String masterData = 'masterdata'; 
  static const String masterDataArea = 'master_data_area';
  static const String masterDataDepartment = 'master_data_department';
  static const String masterDataPlant = 'master_data_plant';
  static const String masterDataRole = 'master_data_role';
  static const String masterDataUser = 'master_data_user';
  static const String settings = 'settings';
  static const String notifications = 'notifications';
  static const String profile = 'profile';

  
  static const String homeFullPath = '$dashboardBase/home';
  static const String masterDataFullPath = '$dashboardBase/masterdata';
  static const String masterDataAreaFullPath = '$dashboardBase/masterdata/area';
  static const String masterDataDepartmentFullPath = '$dashboardBase/masterdata/department';
  static const String masterDataPlantFullPath = '$dashboardBase/masterdata/plant';
  static const String masterDataRoleFullPath = '$dashboardBase/masterdata/role';
  static const String masterDataUserFullPath = '$dashboardBase/masterdata/user';
  static const String settingsFullPath = '$dashboardBase/settings';
  static const String notificationsFullPath = '$dashboardBase/notifications';
  static const String profileFullPath = '$dashboardBase/profile';

  static const String logoutAction = 'logout_action'; 

  // Peta untuk memetakan nama rute ke judul yang ramah pengguna.
  // Ini menjadi satu-satunya sumber kebenaran untuk judul header.
  static const Map<String, String> pageTitles = {
    home: 'Dashboard',
    masterData: 'Pilih Master Data',
    masterDataArea: 'Data Master Area',
    masterDataDepartment: 'Data Master Department',
    masterDataPlant: 'Data Master Plant',
    masterDataRole: 'Data Master Role',
    masterDataUser: 'Data Master User',
    settings: 'Settings',
    notifications: 'Notifications',
    profile: 'Profile',
  };

  // Peta untuk memetakan fullPath ke nama rute yang sesuai.
  // Digunakan untuk mendapatkan nama rute yang benar dari fullPath GoRouter.
  static const Map<String, String> fullPathToRouteName = {
    homeFullPath: home,
    masterDataFullPath: masterData,
    masterDataAreaFullPath: masterDataArea,
    masterDataDepartmentFullPath: masterDataDepartment,
    masterDataPlantFullPath: masterDataPlant,
    masterDataRoleFullPath: masterDataRole,
    masterDataUserFullPath: masterDataUser,
    settingsFullPath: settings,
    notificationsFullPath: notifications,
    profileFullPath: profile,
    dashboardBase: home, // Untuk kasus /dashboard (base path)
  };
}