import 'package:get/get.dart';

import '../providers/booking_provider.dart';
import '../providers/activity_provider.dart';
import '../providers/dashboard_provider.dart';
import '../providers/user_provider.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityProvider>(() => ActivityProvider());
    Get.lazyPut<BookingProvider>(() => BookingProvider());
    Get.lazyPut<DashboardProvider>(() => DashboardProvider());
    Get.lazyPut<UserProvider>(() => UserProvider());
  }
}
