import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../services/global_var.dart';
import '../../../services/shared_prefs.dart';

class TimSurveiIndexTrackingViewModel extends IndexTrackingViewModel {
  final log = getLogger('TimSurveiIndexTrackingViewModel');
  final mySharedPrefs = locator<MySharedPrefs>();
  final navigationService = locator<NavigationService>();
  final snackbarService = locator<SnackbarService>();
  final globalVar = locator<GlobalVar>();

  final _bottomNavBarList = [
    {
      'name': 'Survei',
      'icon': Icons.supervised_user_circle_outlined,
      'header': 'Halaman Survei',
    },
    {
      'name': 'History',
      'icon': Icons.history_edu_outlined,
      'header': 'History Survei',
    },
    {
      'name': 'Pengaturan',
      'icon': Icons.settings_outlined,
      'header': 'Pengaturan',
    },
  ];

  String header = 'Pengaturan';

  List<Map<String, dynamic>> get bottomNavBarList => _bottomNavBarList;

  final List<String> _views = [
    TimSurveiIndexTrackingViewRoutes.halamanSurveiView,
    TimSurveiIndexTrackingViewRoutes.halamanHistoryView,
    TimSurveiIndexTrackingViewRoutes.halamanPengaturanView,
  ];

  Future<void> init() async {
    if (await mySharedPrefs.getString('level') != 'tim_survei') {
      snackbarService.showSnackbar(
        message: 'Anda tidak memiliki akses',
        title: 'Akses Ditolak',
        duration: const Duration(milliseconds: 2500),
      );
      navigationService.clearStackAndShow(Routes.loginScreenView);
    }
    setIndex(2);
  }

  void handleNavigation(int index) {
    // log.d("handleNavigation: $index");
    // log.d("currentIndex: $currentIndex");

    // if (currentIndex == index) return;

    setIndex(index);
    header = _bottomNavBarList[index]['header'] as String;
    navigationService.navigateTo(
      _views[index],
      id: 5,
    );
  }
}
