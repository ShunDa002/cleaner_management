import 'package:get/get.dart';

import 'package:cleaner_management/pages/cleaning_activity/update_status.dart';
import 'package:cleaner_management/pages/dashboard/cleaner_dashboard.dart';
import 'package:cleaner_management/pages/tabs.dart';

class AppPage{
  static final routes= [
        GetPage(name: "/", page: () => const Tabs()),
        GetPage(name: "/updatestatus", page: () => const UpdateStatusPage()),
        GetPage(name: "/cleanerdashboard", page: () => const CleanerDashboardPage()),
      ];
}
